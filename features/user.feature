Feature: Make sure I can sign up, sign in, sign out, etc.


Scenario: Make me sign in.
  When I visit the homepage
  Then I should see "Sign in"

Scenario: Let me sign up, and send me the confirmation email
  When I visit the homepage
  And I click on "Sign up"
  And I fill in "user[name]" with "Peter Tester"
  And I fill in "user[email]" with "peter.tester@bbc.co.uk"
  And I fill in "user[password]" with "supersecret"
  And I fill in "user[password_confirmation]" with "supersecret"
  And I click on "Sign up" button
  Then "peter.tester@bbc.co.uk" should receive an email with subject "Please confirm your email."

Scenario: Sign in, see my username, then sign out, don't see username
  Given I sign in as a non-admin user
  And I visit the homepage
  Then I should see "Petronius"
  When I click "Sign out"
  Then I should NOT see "Petronius"
