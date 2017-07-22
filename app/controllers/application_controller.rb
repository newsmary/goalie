class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #now using devise
  #unless  ENV['RAILS_ENV'] == 'test' || ENV['RAILS_ENV'] == 'development'
  #  http_basic_authenticate_with name: ENV['BASIC_AUTH_USER'], password: ENV['BASIC_AUTH_PASS']
  #end

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
