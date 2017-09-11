class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:update, :destroy, :edit]
  before_action(:only=> :index) do |controller|
    check_admin unless controller.request.format.html?
  end

  # GET /people
  # GET /people.json
  def index
    @people = Person.all.page params[:page]
    respond_to do |format|
      format.html
      format.csv { export }
    end
  end

  #todo...dry this up, too.
  def export
    #show the export if we're testing so that cucumber can look at it...
    if(ENV['RAILS_ENV'] == 'test')
      render plain: "<pre>" + Person.to_csv
    else
      send_data Person.to_csv, filename: "people-#{Date.today}.csv"
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  #def new
  #  @person = Person.new
  #end

  # GET /people/1/edit
  def edit
    #raise (current_user.email == @person.email).to_s
  end

  # POST /people
  # POST /people.json
  #def create
  #  @person = Person.new(person_params)
  #
  #  respond_to do |format|
  #    if @person.save
  #      format.html { redirect_to @person, notice: 'Person was successfully created.' }
  #      format.json { render :show, status: :created, location: @person }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @person.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update

    #raise person_params[:admin]

    if(current_user.email == @person.email)
      redirect_to people_path, alert: "Can't make yourself a non-admin. Please get another admin to do this."
      return
    end

    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
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
      params.require(:person).permit(:name, :email, :admin)
    end
end
