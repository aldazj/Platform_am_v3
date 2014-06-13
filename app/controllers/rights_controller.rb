class RightsController < ApplicationController
  before_action :set_right, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_person
  before_filter :verify_access

  # GET /rights
  # GET /rights.json
  def index
    @rights = Right.all
  end

  # GET /rights/1
  # GET /rights/1.json
  def show
  end

  # GET /rights/new
  def new
    @right = Right.new
  end

  # GET /rights/1/edit
  def edit
  end

  # POST /rights
  # POST /rights.json
  def create
    @right = Right.new(right_params)

    respond_to do |format|
      if @right.save
        format.html { redirect_to @right, notice: 'Right was successfully created.' }
        format.json { render action: 'show', status: :created, location: @right }
      else
        format.html { render action: 'new' }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rights/1
  # PATCH/PUT /rights/1.json
  def update
    respond_to do |format|
      if @right.update(right_params)
        format.html { redirect_to @right, notice: 'Right was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rights/1
  # DELETE /rights/1.json
  def destroy
    @right.destroy
    respond_to do |format|
      format.html { redirect_to rights_url }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_right
      @right = Right.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def right_params
      params.require(:right).permit(:name, :is_available)
    end

    def verify_access
        if current_person.type != 'Admin'
            respond_to do |format|
                format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity, :layout => false }
            end
        end
    end
end
