class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_person, only: [:index, :edit, :update]
  before_filter :verify_access
  #before_filter :correct_person, only: [:edit, :update]

  helper_method :sort_column, :sort_direction

  # GET /people
  # GET /people.json
  def index
    #@people = Person.all

    case params[:type]
      when 'admin'
            #@people = Admin.all
      when 'user'
            #@people = User.all
      when 'person'
            #@people = Person.all
            @people = Person.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 7, :page => params[:page])
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    case params[:type]
        when 'admin'
            @person = Admin.new(person_params)
        when 'user'
            @person = User.new(person_params)
        when 'person'
            @person = Person.new(person_params)
    end

    #   Create Groups
    @person.groups.clear

    params[:person][:group_ids] ||= []
    params[:person][:group_ids].each do |group|
        if !(group.blank?)
            @person.add_group(Group.find_by_id(group))
        end
    end

    respond_to do |format|
      if @person.save
        #Personal group creation
        if @person.personalgroup.nil?
            Personalgroup.create(person_id: @person.id)
        end

        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render action: 'show', status: :created, location: @person }
      else
        format.html { render action: 'new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    #     Update Groups
    @person.groups.clear
    params[:person][:group_ids] ||= []
    params[:person][:group_ids].each do |group|
        if !(group.blank?)
            @person.add_group(Group.find_by_id(group))
        end
    end

    #     Update Personal Group
    personalGroup = Personalgroup.find_by_person_id(@person)
    personalGroup.rights.clear

    params[:personalgroup][:right_ids] ||= []
    params[:personalgroup][:right_ids].each do |right|
        if !(right.blank?)
            personalGroup.add_right_to_personalgroup(Right.find_by_id(right))
        end
    end

    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
        #sign_in @person
        #redirect_to @person
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      #params.require(:person).permit(:lastname, :firstname, :email, :dateofbirth, :private_phone, :professional_phone, :password, :password_confirmation, :type,
      #                               videoitems_attributes: [:id, :title, :description, :is_available, :date, :views, :pathvideo, :_destroy])

      if params[:admin] != nil
          params.require(:admin).permit(:lastname, :firstname, :email, :dateofbirth, :private_phone, :professional_phone, :password, :password_confirmation,:type,
                                         videoitems_attributes: [:id, :title, :description, :is_available, :date, :views, :pathvideo, :_destroy])
      elsif params[:user] != nil
          params.require(:user).permit(:lastname, :firstname, :email, :dateofbirth, :private_phone, :professional_phone, :password, :password_confirmation, :type,
                                         videoitems_attributes: [:id, :title, :description, :is_available, :date, :views, :pathvideo, :_destroy])
      elsif params[:person] != nil
          params.require(:person).permit(:lastname, :firstname, :email, :dateofbirth, :private_phone, :professional_phone, :password, :password_confirmation, :type,
                                         videoitems_attributes: [:id, :title, :description, :is_available, :date, :views, :pathvideo, :_destroy])
      end
    end

    def signed_in_person
      redirect_to signin_path, notice: 'Please sign in.' unless signed_in?
    end

    def correct_person
        @person = Person.find(params[:id])
        redirect_to signin_path unless current_person?(@person)
    end

    def verify_access
        if current_person.type != 'Admin'
            if !current_person?(@person)
                respond_to do |format|
                    format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity, :layout => false }
                end
            end
        end
    end

    def sort_column
      Person.column_names.include?(params[:sort]) ? params[:sort] : "lastname"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
