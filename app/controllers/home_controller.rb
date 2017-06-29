class HomeController < ApplicationController
  def index
  end

  def about
    @active_nav = "about"
  end
end
