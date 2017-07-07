class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :import_okrs]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.where(parent: nil)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end


  def import_okrs
    text = params[:okr_text]
    if(text)
      #msg = Goal.import_okrs(params[:okr_text])

      msg = ""

      @team.goals.destroy_all
      current_objective = nil
      #strip out the "key result" and "grade" lines
      text.gsub(/^\s*Key result(s?)\s*$/i,"").gsub(/^\s*Grade\s*$/i,"").gsub(/^\s*$/,'').split("\n").each do |line|
        if(!line.empty?)
          obj_regex = /^\s*Obj.+\s*:\s*/i

          if obj_regex === line
            current_objective = Goal.create!(team: @team, name: line.gsub(obj_regex,""))
            @team.goals << current_objective
          else
            child_goal = Goal.create!(name: line, team: @team, parent: current_objective)
            #binding.pry
            current_objective.children << child_goal
          end
        end
      end

      @team.save!


      if(msg.to_s.empty?)
        redirect_to @team, notice: "Import successful."
      else
        redirect_to @team, flash: {:error=> msg}
      end
    else
      redirect_to @team, flash: {:error=> "Oops, no CVS file specified."}
    end
  end


  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    if(!@team.goals.empty?)
      redirect_to @team, flash: {:error=> "Cannot delete a team that has goals. Please re-assign the goals first."}
      return
    end
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :url, :body, :parent_id)
    end
end
