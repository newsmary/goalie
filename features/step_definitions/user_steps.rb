When(/^I sign in as a non-admin user$/) do
  user = User.new({:email => "spammy@somewhere.com", :password=>"something", :password_confirmation=>"something", :name=>"Petronius"})
  user.skip_confirmation!

  #don't validate for this... otherwise the tests are dependent on the "allowed domain" env variable
  user.save(validate:false)

  login_as(user, :scope=>:user)

end

Given(/^the allowable domain is "([^"]*)"$/) do |domain|
  Rails.application.config.valid_email_domain = domain
end

When(/^I sign in as an admin user$/) do
  user = User.new({:email => "admin@somewhere.com", :admin=>true, :password=>"something", :password_confirmation=>"something", :name=>"PK Admin"})
  user.skip_confirmation!

  #don't validate for this... otherwise the tests are dependent on the "allowed domain" env variable
  user.save(validate:false)

  login_as(user, :scope=>:user)

end
