class AdminController < ApplicationController
  before_action :check_admin

  def index
  end

  #possibly bad design... a single import function that susses out which file you've uploaded and adds data accordingly.
  def import
    if(params[:file])
      require 'csv'
      #figure out what kind of import it is
      headers = CSV.read(params[:file].path,headers: true).headers

      #TODO: refactor this mess...
      if headers.sort == Team::HEADERS.sort
        msg = Team.import(params[:file])
        type = "team"
      elsif headers.sort == Person::HEADERS.sort
        msg = Person.import(params[:file])
        type = "person"
      elsif headers.sort == Goal::HEADERS.sort
        msg = Goal.import(params[:file])
        type = "goal"
      elsif headers.sort == Score::HEADERS.sort
        msg = Score.import(params[:file])
        type = "goal"
      else
        msg = "No valid headers found in your file. Please check that your CSV has the required headers and try again."
      end

=begin
      if headers.sort == Goal.HEADERS.sort
        msg = Goal.import_okrs(params[:file])
      end

      if headers.sort == User.HEADERS.sort
        msg = User.import_okrs(params[:file])
      end

      if headers.sort == Score.HEADERS.sort
        msg = Score.import_okrs(params[:file])
      end
=end

      #msg = Goal.import_okrs(params[:file])
      #missing_cols = required_cols - CSV.read(file.path,headers: true).headers

      if(msg.to_s.empty? && type.present?)
        redirect_to admin_path, notice: "Successfully imported #{type}."
      else
        redirect_to admin_path, flash: {:error=> msg}
      end
    else
      redirect_to admin_path, flash: {:error=> "Oops, no CVS file specified."}
    end
  end
end
