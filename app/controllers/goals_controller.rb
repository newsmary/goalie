class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  # GET /goals
  # GET /goals.json
  def index
    @goals = Goal.all
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new
    @goal.parent = Goal.find_by_id(params[:parent])
    #attempt to find a team if we've passed in an ID
    #TODO: friendly IDs
    begin
      team = Team.find(params[:team]) if params[:team]
      team = @goal.parent.team if @goal.parent
    rescue ActiveRecord::RecordNotFound
      team = nil
    end

    @goal.team = team
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(goal_params)

    redirect_url = @goal.parent.nil? ? @goal.owner : @goal.parent

    respond_to do |format|
      if @goal.save
        format.html { redirect_to redirect_url, notice: 'Goal was successfully created.' }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy

    if(!@goal.children.empty?)
      redirect_to @goal, flash: {:error=> "Goals may only be deleted if they have no sub-goals. Please delete all sub-goals and try again."}
      return
    end

    @goal.destroy

    redirect_url = (@goal.parent) ? @goal.parent : @goal.owner

    respond_to do |format|
      format.html { redirect_to redirect_url, notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    #@goals = Goal.all.search(params[:q]) if params[:q].present?
    if params[:q].present?
      words = params[:q]
      @goals = Goal.where('lower(name) LIKE ?',"%#{words.downcase}%")
      @teams = Team.where('lower(name) LIKE ?',"%#{words.downcase}%")
      #.where("lower(name) LIKE ? ","%#{words.downcase}%").collect{|u| u.goals}.flatten
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
      @team = @goal.team
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:name, :parent_id, :body, :quarter, :team_id)
    end
end
