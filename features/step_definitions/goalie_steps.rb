

include Warden::Test::Helpers

When(/^I sign in as a non-admin user$/) do
  user = User.create!({:email => "Peter.Kappus.ext1@bbc.co.uk", :password=>"something", :password_confirmation=>"something", :name=>"Petronius"})

  login_as(user, :scope=>:user)

end
