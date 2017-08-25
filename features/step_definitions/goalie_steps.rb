

include Warden::Test::Helpers



When(/^I visit the objective called "([^"]*)"$/) do |name|
  visit goal_path(Goal.find_by(name: name))
end

Given(/^the objective "([^"]*)" has a key result "([^"]*)"$/) do |obj_name, key_result_name|
  g = Goal.find_by(name: obj_name)
  g.key_results << Goal.create!(name: key_result_name, team: g.team)
end


#http://vedanova.com/rails/cucumber/2013/08/02/run-rake-tasks-cucumber-rspec.html
def execute_rake(file, task)
  require 'rake'
  rake = Rake::Application.new
  Rake.application = rake
  Rake::Task.define_task(:environment)
  load "#{Rails.root}/lib/tasks/#{file}"
  rake[task].invoke
end
