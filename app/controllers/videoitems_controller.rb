class VideoitemsController < ApplicationController
  before_action :set_videoitem, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_person

  # GET /videoitems
  # GET /videoitems.json
  def index
    @videoitems = Videoitem.all
  end

  # GET /videoitems/1
  # GET /videoitems/1.json
  def show
      @videoitem.increment!(:views)
      @videoitem = Videoitem.find(params[:id])
      @owner = Person.find_by_id(@videoitem.person_id)
      @new_comment = @videoitem.comments.build
  end

  # GET /videoitems/new
  def new
    @videoitem = Videoitem.new
    @new_image = @videoitem.assets.build
  end

  # GET /videoitems/1/edit
  def edit
      @new_image = @videoitem.assets.build
  end

  # POST /videoitems
  # POST /videoitems.json
  def create
    #@videoitem = Videoitem.new(videoitem_params)
    #@videoitem.views = 0

    #@videoitem = @person.videoitems.new(videoitem_params)
    @videoitem = current_person.videoitems.new(videoitem_params)
    @videoitem.views = 0

    respond_to do |format|
      if @videoitem.save
        format.html { redirect_to @videoitem, notice: 'Videoitem was successfully created.' }
        format.json { render action: 'show', status: :created, location: @videoitem }
      else
        format.html { render action: 'new' }
        format.json { render json: @videoitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videoitems/1
  # PATCH/PUT /videoitems/1.json
  def update
    respond_to do |format|
      if @videoitem.update(videoitem_params)
        format.html { redirect_to @videoitem, notice: 'Videoitem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @videoitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videoitems/1
  # DELETE /videoitems/1.json
  def destroy
    @videoitem.destroy
    respond_to do |format|
      format.html { redirect_to videoitems_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_videoitem
      @videoitem = Videoitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def videoitem_params
      params.require(:videoitem).permit(:title, :description, :is_available, :date, :views, :pathvideo,
                                        comments_attributes: [:id, :message, :is_available, :date, :url_for, :_destroy],
                                        assets_attributes: [:id, :image, :_destroy])
    end
end
