class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]
  #before_action :check_admin, only: [:edit, :update, :destroy]

  # GET /scores
  # GET /scores.json
  def index
    #@scores = Score.all
    #redirect to goal
    redirect_to Goal.find(params[:goal_id])
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
    #redirect to goal
    redirect_to Goal.find(params[:goal_id])
  end

  # GET /scores/new
  def new
    @goal = Goal.find(params[:goal_id])

    if(@goal.nil?)
      flash[:error] = "Could not find goal with id #{params[:goal_id]}"
      redirect_to root_path
    end

    #otherwise... we're good to go...

    #do we have a previous score to use as a template?
    if @goal.score
      #copy it
      @score = @goal.score.dup
    else
      #make a blank one
      @score = Score.new
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:amount, :reason, :status_id, :goal_id, :user_id)
    end
end
