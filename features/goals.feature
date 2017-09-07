Feature: Do some basic things with teams and goals (CRUD)


Scenario: Make an objective and give it a KR
  Given I sign in as a non-admin named "Paul" with the email "test@test.com"
  And I have a team called "Nitzer Ebb" with an objective to "Join in the chant"
  When I visit the team page for "Nitzer Ebb"
  And I click on "Join in the chant"
  And I click on "Add a key result"
  And I fill in "goal[name]" with "Moar stuff"
  And I click "Create key result"
  Then I should see "success"