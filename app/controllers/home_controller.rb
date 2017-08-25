class HomeController < ApplicationController
before_action :authenticate_user!, except: [:debug_sign_in]
  def index

  end

  def about
    @active_nav = "about"
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
