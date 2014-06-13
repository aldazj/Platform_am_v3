class VideoClipStepsController < ApplicationController
  include Wicked::Wizard

  steps :thumbnail_page, :select_thumbnail_page

  def show
    @video_clip = VideoClip.find(params[:video_clip_id])
    case step
      when :thumbnail_page
        @video_clip.thumbnails.build
    end
    render_wizard
  end


  def update
      @video_clip = VideoClip.find(params[:video_clip][:video_clip_id])

      case step
      when :thumbnail_page
          if @video_clip.update_attributes(video_clip_params)
             redirect_to wizard_path(:select_thumbnail_page, :video_clip_id => @video_clip.id), notice: 'Videoclip was successfully upload.'
            #redirect_to wizard_path(:select_thumbnail_page, :video_clip_id => @video_clip.id)
          else

          end
      when :select_thumbnail_page
          select_thumbnail = 0
          @video_clip.thumbnails.each do |thumbnail|
              if thumbnail.id == params[:main_thumbnail].to_i
                thumbnail.main_thumbnail = true
                select_thumbnail += 1
              else
                thumbnail.main_thumbnail = false
              end
          end

          if select_thumbnail == 1
            if @video_clip.update_attributes(video_clip_params)
              redirect_to_finish_wizard
            end
          else
            redirect_to wizard_path(:select_thumbnail_page, :video_clip_id => @video_clip.id)
          end
      end
  end

  private
    def video_clip_params
      params.require(:video_clip).permit(:title, :description, :is_available, :date, :views, :videoitemclip, :videoclip_from_url,
                                         thumbnails_attributes: [:id, :image, :main_thumbnail, :_destroy],
                                         formatvideos_attributes: [:id, :format, :_destroy])
    end

    def redirect_to_finish_wizard
      respond_to do |format|
          format.html { redirect_to video_clips_path, notice: 'Videoitem was successfully created.'}
          #format.json { render action: 'show', status: :created, location: @videoitem }
      end
    end

end
