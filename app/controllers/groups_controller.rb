class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_person
  before_filter :verify_access

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  def management
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @group.rights.clear

    params[:group][:right_ids] ||= []
    params[:group][:right_ids].each do |right|
        if !(right.blank?)
            @group.add_right(Right.find_by_id(right))
        end
    end

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
#      debug(params[:group][:right_ids]
      @group = Group.find(params[:id])
      @group.rights.clear

      params[:group][:right_ids] ||= []
      params[:group][:right_ids].each do |right|
        if !(right.blank?)
            @group.add_right(Right.find_by_id(right))
        end
      end

      respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, rights_attributes: [:id, :name, :is_available, :right_ids])
    end

    def verify_access
      if current_person.type != 'Admin'
          respond_to do |format|
              format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity, :layout => false }
          end
      end
    end
end
