class HomeController < ApplicationController
before_action :authenticate_user!, except: [:debug_sign_in]
  def index
    if(params[:view] == 'stale')
      @title = "Stale scores"
      @scores = Score.order('created_at').limit(10)
    else
      @title = "Recently updated scores"
      @scores = Score.order('created_at desc').limit(10)
    end
  end

  def about
    @active_nav = "about"
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

  #simple GET request login for testing (ONLY works in Dev & Test)
  #bypasses domain restrictions and creates a new session
  #user must exist in database
  def debug_sign_in
    if ((Rails.env.test? || Rails.env.development?) && params['email'].present?)
      #create this user in the step definition
      if(user = User.find_by_email(params['email']))
        sign_in user
        flash['notice'] = "Successfully signed in as " + user.name.to_s
      else
        flash['error'] = "Could not find test user with email " + params['email'].to_s
      end
      redirect_to "/"
    end
  end
end
