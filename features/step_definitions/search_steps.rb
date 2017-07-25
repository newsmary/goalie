Given(/^"([^"]*)" have an objective named "([^"]*)"$/) do |team_name, obj_name|
  Team.find_by(name: team_name).objectives << Goal.create!(name: obj_name)
end

When(/^I search for "([^"]*)"$/) do |arg1|

end
