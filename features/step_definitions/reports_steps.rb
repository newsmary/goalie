
Given(/^I've set up the default statuses$/) do
  execute_rake('statuses.rake','statuses:seed')
end

Given(/^I have a team called "([^"]*)" with some scored OKRs from last quarter$/) do |name|
  create_scored_okrs_by_team_and_quarter(name,-3) #back three months
end
