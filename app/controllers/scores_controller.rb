class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]
  #before_action :check_admin, only: [:edit, :update, :destroy]

  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.all
    #redirect to goal
    #redirect_to Goal.find(params[:goal_id])
    respond_to do |format|
      format.html
      format.csv { export }
    end
  end

  #todo...dry this up, too.
  def export
    #show the export if we're testing so that cucumber can look at it...
    if(ENV['RAILS_ENV'] == 'test')
      render plain: "<pre>" + Score.to_csv
    else
      send_data Score.to_csv, filename: "scores-#{Date.today}.csv"
    end
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
    #redirect to goal
    redirect_to @goal
  end

  # GET /scores/new
  def new
    @goal = Goal.find(params[:goal_id])

    if(@goal.nil?)
      flash[:error] = "Could not find goal with id #{params[:goal_id]}"
      redirect_to root_path
    end

    #otherwise... we're good to go...

    #should we have learnings but we don't?
    #if @score.status.require_learnings? && ! @score.learnings.present?

    #do we have a previous score to use as a template?
    if @goal.score
      #copy it
      @score = @goal.score.dup
      #but not the comments... want people to make new ones
      @score.reason = @score.learnings =  ''

    else
      #make a blank one
      @score = Score.new
      @score.status = Status.first

      #assign it to this goal
      @score.goal = @goal
    end

  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new(score_params)
    @score.user = current_user

    respond_to do |format|
      if @score.save
        format.html { redirect_to @score.goal, notice: 'Successfully added progress. Thanks. You\'re the greatest!' }
        format.json { render :show, status: :created, location: @score }
      else
        #The "new" template references @goal and gets rendered when validation fails so we must set @goal.
        @goal = @score.goal
        format.html { render :new }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    @score.user = current_user
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to @score.goal, notice: 'Score was successfully updated.' }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url, notice: 'Score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
      @goal = @score.goal
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:amount, :reason, :learnings, :status_id, :confidence, :goal_id, :user_id)
    end
end
