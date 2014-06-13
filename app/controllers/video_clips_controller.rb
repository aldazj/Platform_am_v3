class VideoClipsController < ApplicationController
  before_action :set_video_clip, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_person

  require 'json'
  require 'open-uri'

  # GET /video_clips
  # GET /video_clips.json
  def index
    #@video_clips = VideoClip.all
    @video_clips  = VideoClip.search_video(params[:search_video], current_person).paginate(:per_page => 10, :page => params[:page])
  end

  def indexUnavailable
    @video_clips_unavailable = VideoClip.search_video_unavailable(params[:search_video_unavailable], current_person).paginate(:per_page => 10, :page => params[:page])
  end

  # GET /video_clips/1
  # GET /video_clips/1.json
  def show
    verify_access_video(@video_clip, 'show')
    @video_clip.increment!(:views)
    @video_clip = VideoClip.find_by_token(params[:id])
    #@video_clip_comments = @video_clip.comments.order("id DESC").paginate(:per_page => 3, :page => params[:page])
    @owner = Person.find_by_id(@video_clip.person_id)
    @new_comment = @video_clip.comments.build

    if @video_clip.videoclip_from_url.empty?
      @file_video = @video_clip.videoitemclip.url
    else
      @file_video = @video_clip.videoclip_from_url
    end

    @thumb_main = nil
    @video_clip.thumbnails.each do |thumbnail|
      if thumbnail.main_thumbnail == true
        @thumb_main = thumbnail
        break
      end
    end
  end

  # GET /video_clips/new
  def new
    verify_access_video(@video_clip, 'new')
    @video_clip = VideoClip.new
    @video_clip.thumbnails.build
  end

  # GET /video_clips/1/edit
  def edit
    verify_access_video(@video_clip, 'edit')
    @video_clip.thumbnails.build
  end

  # POST /video_clips
  # POST /video_clips.json
  def create
    @video_clip = VideoClip.new(video_clip_params)
    thumbnails = Array.new
    @video_clip.views = 0
    @video_clip.person_id = current_person.id
    respond_to do |format|
      if @video_clip.save

        if (@video_clip.videoclip_from_url.empty?)
            filename = @video_clip.videoitemclip_file_name.split('.')[0..-1][0].to_s
            path = @video_clip.videoitemclip.path.to_s
            url = @video_clip.videoitemclip.url
            content = @video_clip.videoitemclip.content_type

            createDirectory(path)
            videoflv = convert_video_to_flv(filename, path, content, url)
            storeFormatOnAmazonS3(@video_clip, videoflv, 'FormatFvl')

            time_video_flv_sec = get_time_flv_in_sec(videoflv, "Duration").gsub(/\n$/,'').to_i
            shift_time = ((time_video_flv_sec*20).to_f/100) #chaque 20% de la video on prend une vignette
            step = 1
            time_tmp = 0

            while time_tmp < time_video_flv_sec
              thumbnail = generate_thumbnail_from_video(filename, videoflv, time_tmp, step)
              thumbnails << thumbnail
              time_tmp += shift_time
              step += 1
            end
            storeThumbnailsOnAmazonS3(thumbnails)
        end
        format.html{ redirect_to video_clip_steps_path(:video_clip_id => @video_clip.id), notice: ' A A' }
        format.json { render action: 'show', status: :created, location: @video_clip }
      else
        format.html { render action: 'new' }
        format.json { render json: @video_clip.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /video_clips/1
  # PATCH/PUT /video_clips/1.json
  def update
    select_thumbnail = 0
    @video_clip.thumbnails.each do |thumbnail|
      if thumbnail.id == params[:main_thumbnail].to_i
        thumbnail.main_thumbnail = true
        select_thumbnail += 1
      else
        thumbnail.main_thumbnail = false
      end
    end

    respond_to do |format|
      if @video_clip.update(video_clip_params) && select_thumbnail == 1
        format.html { redirect_to @video_clip, notice: 'Video clip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video_clip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video_clips/1
  # DELETE /video_clips/1.json
  def destroy
    verify_access_video(@video_clip, 'delete')
    @video_clip.destroy
    respond_to do |format|
      format.html { redirect_to video_clips_url }
      format.json { head :no_content }
    end
  end

  def download
    video_clip = VideoClip.find(params[:id])
    video_clip_url = nil
    if video_clip.videoclip_from_url.empty?
      video_clip_url = video_clip.videoitemclip.url
      file_name = video_clip.videoitemclip_file_name
    else
      video_clip_url = video_clip.videoclip_from_url
      file_name = video_clip.title
    end

    #current_comments.pictures.create!(file: URI.parse(image_url))
    data = open(video_clip_url)
    send_data data.read, :filename => file_name, :type => data.content_type, :x_sendfile => true
  end

  def download_url
    video_clip = VideoClip.find(params[:id])
    s3 = AWS::S3.new.buckets[ 'aldazjvideo.com' ] # This can be done elsewhere as well.
    s3.url_for( :read,
                expires_in: 60.minutes,
                use_ssl: true,
                response_content_disposition: "attachment; filename='#{video_clip.videoitemclip_file_name}'" ).to_s
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_video_clip
      @video_clip = VideoClip.find_by_token(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_clip_params
      params.require(:video_clip).permit(:title, :description, :is_available, :date, :views, :videoitemclip, :delete_at, :videoclip_from_url,
                                         thumbnails_attributes: [:id, :image, :_destroy, :main_thumbnail],
                                         formatvideos_attributes: [:id, :format, :_destroy],
                                         comments_attributes: [:id, :message, :is_available, :date, :url_for, :_destroy])
    end


    def convert_video_to_flv(filename, path, content, url)
      logger.debug "Convert the video ( #{filename} ) path ( #{path}) from content type of #{content} to flv"
      File.new(File.join(Rails.root, 'public' , 'system', File.dirname(path), "#{filename}.flv"), File::CREAT | File::TRUNC| File::RDWR, 0644)
      videoflv = File.join(Rails.root, 'public' , 'system', File.dirname(path), "#{filename}.flv")
      system("ffmpeg -i #{url} -r 25 -ar 44100 -vcodec flv -ab 32 -y -f flv -s 320x240 #{videoflv}")
      return videoflv
    end

    def convert_video_to_H264(filename, path, content, url)
      logger.debug "Convert the video ( #{filename} ) path ( #{path}) from content type of #{content} to H264"
      File.new(File.join(Rails.root, 'public' , 'system', File.dirname(path), "#{filename}.h264"), File::CREAT | File::TRUNC| File::RDWR, 0644)
      videoh264 = File.join(Rails.root, 'public' , 'system', File.dirname(path), "#{filename}.h264")
      system("ffmpeg -i #{url} -an -vcodec libx264 -crf 23 #{videoh264} -y")
      return videoh264
    end

    def convert_video_to_AVI(filename, path, content, url)
      logger.debug "Convert the video ( #{filename} ) path ( #{path}) from content type of #{content} to H264"
      File.new(File.join(Rails.root, 'public' , 'system', File.dirname(path), "#{filename}.avi"), File::CREAT | File::TRUNC| File::RDWR, 0644)
      videoavi = File.join(Rails.root, 'public' , 'system', File.dirname(path), "#{filename}.avi")
      system("ffmpeg -i #{url} -acodec copy -vcodec copy #{videoavi} -y")
      return videoavi
    end

    def createDirectory(path)
      dir = File.dirname(File.join( Rails.root, 'public' , 'system', path))
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
    end

    def get_time_flv_in_sec(video_flv, duration)
      return `ffmpeg -i #{video_flv} 2>&1 | grep #{duration}| cut -d ' ' -f 4 | sed s/,// | sed 's@\\..*@@g' | awk '{ split($1, A, ":"); split(A[3], B, "."); print 3600*A[1] + 60*A[2] + B[1] }'`
    end

    def generate_thumbnail_from_video(filename, videoflv, time, step)
      logger.debug "Trying to generate screenshots from #{videoflv}"
      asset = File.join(File.dirname(videoflv), "#{filename}_#{step}.jpg")
      system("ffmpeg -ss #{time} -i #{videoflv} -s 320x240 -vframes 1 -f image2 -an #{asset}")
      return asset
    end

    def storeFormatOnAmazonS3(videomp4, videoconverted, format)
      Formatvideo.create({
                             :video_clip_id => videomp4.id,
                             :format =>  File.open(videoconverted),
                             :type => format
                         })
    end

    def storeThumbnailsOnAmazonS3(thumbnails)
      thumbnails.each do |thumb|
        Thumbnail.create({:image => File.open(thumb),
                          :video_clip_id => @video_clip.id,
                          :main_thumbnail => false
                         })
      end
    end

    def verify_access_video(video_clip, current_action)
      case current_action
        when 'show'
          if !(video_clip.is_available?)
            if(current_person.type != 'Admin' && !(current_person_is_video_owner?(video_clip)))
              respond_to do |format|
                format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity, :layout => false }
              end
            end
          end
        when 'edit'
          if(current_person.type != 'Admin' && !(current_person_is_video_owner?(video_clip)))
            respond_to do |format|
              format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity, :layout => false }
            end
          end
        when 'new'
          if current_person.type != 'Admin'
            if !(right_in_current_person_personalgroup?('Upload'))
              if !(current_person_groups_enable?)
                respond_to do |format|
                  format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity, :layout => false }
                end
              else
                if !(right_in_current_person_groups?('Upload'))
                  respond_to do |format|
                    format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity, :layout => false }
                  end
                end
              end
            end
          end
        when 'delete'
          if current_person.type != 'Admin'
            if !(current_person_is_video_owner?(video_clip))
              respond_to do |format|
                format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity, :layout => false }
              end
            end
          end
      end
    end
end
