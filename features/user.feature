Feature: Make sure I can sign up, sign in, sign out, etc.

Scenario: Make me sign in.
  When I visit the homepage
  Then I should see "Sign in"

Scenario: DON'T Let me sign up, with an invalid email domain
  When I visit the homepage
  And I click on "Sign up"
  And I fill in "user[name]" with "Peter Tester"
  Given the allowable domain is "somedomain2017.com"
  And I fill in "user[email]" with "peter.tester@invaliddomain2017.com"
  And I fill in "user[password]" with "supersecret"
  And I fill in "user[password_confirmation]" with "supersecret"
  And I click on "Sign up" button
  Then I should see "must be in the domain somedomain2017.com"

Scenario: Let me sign up, and send me the confirmation email
  When I visit the homepage
  And I click on "Sign up"
  And I fill in "user[name]" with "Peter Tester"
  Given the allowable domain is "somedomain2017.com"
  And I fill in "user[email]" with "peter.tester@somedomain2017.com"
  And I fill in "user[password]" with "supersecret"
  And I fill in "user[password_confirmation]" with "supersecret"
  And I click on "Sign up" button
  Then "peter.tester@somedomain2017.com" should receive an email with subject "Please confirm your email."

Scenario: Sign in and see my name, then sign out and don't see my name
  Given I sign in as a non-admin user
  And I visit the homepage
  Then I should see "Petronius"
  When I click "Sign out"
  Then I should NOT see "Petronius"

Scenario: Sign in as a non-admin and don't see option to modify people. Then log in as admin and see "edit", "destroy" buttons
  Given I sign in as a non-admin user
  And I visit the homepage
  And I click on "People" within ".nav"
  Then I should NOT see "Edit"
  And I should NOT see "Destroy"
  When I click "Sign out"
  And I sign in as an admin user
  And I click on "People" within ".nav"
  Then I should see "Edit"
  And I should see "Destroy"

@wip
Scenario: Don't see "edit this team" or "import OKRs" options when you're a non-admin
  Given I have a team called "Bauhaus"
  And I sign in as a non-admin user
  When I visit the homepage
  And I click on "Bauhaus"
  I should NOT see "Edit or move"
  When I sign in as an admin user
  And I visit the homepage
  And I click on "Bauhaus"
  Then I should see "Edit or move"
