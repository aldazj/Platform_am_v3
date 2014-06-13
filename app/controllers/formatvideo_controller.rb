class FormatvideoController < ApplicationController
  def index
    case params[:type]
      when 'Flv'
        @formatvideos = FormatFvl.all
      when 'Ogg'
        @people = FormatOgg.all
      when 'H264'
        @people = FormatH264.all
      else
        @formatvideos = Formatvideo.all
    end
  end

  def show
    @formatvideo = Formatvideo.find(params[:id])
  end

  def new
    @formatvideo = Formatvideo.new
  end

  def edit
    @formatvideo = Formatvideo.find(params[:id])
  end

  def create
    case params[:type]
      when 'Flv'
        @formatvideo = FormatFvl.new(formatvideo_params)
      when 'Ogg'
        @formatvideo = FormatOgg.new(formatvideo_params)
      when 'H264'
        @formatvideo = FormatH264.new(formatvideo_params)
      else
        @formatvideo = Formatvideo.new(formatvideo_params)
    end

    respond_to do |format|
      if @formatvideo.save
        format.html { redirect_to @formatvideo, notice: 'Person was successfully created.' }
        format.json { render action: 'show', status: :created, location: @formatvideo }
      else
        format.html { render action: 'new' }
        format.json { render json: @formatvideo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @formatvideo = Formatvideo.find(params[:id])
    respond_to do |format|
      if @formatvideo.update(person_params)
        format.html { redirect_to @formatvideo, notice: 'Formatvideo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @formatvideo.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @formatvideo.destroy
    respond_to do |format|
      format.html { redirect_to formatvideos_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_formatvideo
    @formatvideo = Formatvideo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def formatvideo_params
    if params[:formatflv] != nil
      params.require(:formatflv).permit(:videoClip_id, :format, :type)
    elsif params[:formatogg] != nil
      params.require(:formatogg).permit(:videoClip_id, :format, :type)
    elsif params[:formatH264] != nil
      params.require(:formatH264).permit(:videoClip_id, :format, :type)
    elsif params[:formatvideo] != nil
      params.require(:formatvideo).permit(:videoClip_id, :format, :type)
    end
  end
end
