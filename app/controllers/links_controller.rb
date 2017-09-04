class LinksController < ApplicationController
  before_action :set_goal
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
    #gsub gives us cheap "or" search (as long as words appear in same order)
    words = params[:related_name].to_s.gsub(/\s+/,"%").downcase
    if(words.present?)
      @goals = Goal.where('lower(name) LIKE ?',"%#{words}%")
    end
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    #@link = Link.new(link_params)
    target_goal = Goal.find(params[:linked_goal_id])
    @link.errors << "Target goal: #{params[:linked_goal_id]} not found." unless target_goal

    #unless @goal.linked_goals.include? target_goal
    #  @goal.linked_goals << target_goal

    respond_to do |format|
      if target_goal && !@goal.linked_goals.any? {|g| g.id == target_goal.id}
        @goal.linked_goals << target_goal
        format.html { redirect_to @goal, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:goal_id])
    end

    def set_link
      @link = @goal.links.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:goal_id, :linked_goal_id)
    end
end
