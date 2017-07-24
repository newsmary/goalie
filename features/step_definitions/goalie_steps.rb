

include Warden::Test::Helpers

When(/^I sign in as a non-admin user$/) do
  user = User.create!({:email => "spammy@bbc.co.uk", :password=>"something", :password_confirmation=>"something", :name=>"Petronius"})

  #make sure user is confirmed since we're using user.confirmable
  user.confirm

  login_as(user, :scope=>:user)

end
