
Given(/^I have a team called "([^"]*)"$/) do |name|
  Team.create!(name: name)
end

When(/^I visit the teams page$/) do
  visit "/"
end

Given(/^the team called "([^"]*)" has an objective to "([^"]*)"$/) do |team_name, goal_name|
  Team.find_by(name: team_name).objectives << Goal.create!(name: goal_name)
end

Given(/^I have a team called "([^"]*)" with an objective to "([^"]*)"$/) do |team_name, goal_name|
  Goal.create!(name: goal_name, team: Team.find_or_create_by!(name: team_name))
end

When(/^I nest the team "([^"]*)" under the team "([^"]*)"$/) do |child, parent|
    t = Team.find_by(name: child)
    t.parent = Team.find_by(name: parent)
    t.save!
end
