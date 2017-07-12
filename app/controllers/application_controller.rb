class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  unless  ENV['RAILS_ENV'] == 'test' || ENV['RAILS_ENV'] == 'development'
    http_basic_authenticate_with name: ENV['BASIC_AUTH_USER'], password: ENV['BASIC_AUTH_PASS']
  end
end
