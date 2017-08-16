
Given(/^I've set up the default statuses$/) do
  execute_rake('statuses.rake','statuses:seed')
end
