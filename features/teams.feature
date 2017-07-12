Feature: Manage teams

Scenario: See teams
  Given I visit "/teams"
  Then I should see "Teams" within "h1"


Scenario: Disallow empty and duplicate team names
  Given I visit "/teams"
  And I click "New team"
  #leave name blank and see error
  And I click "Create Team"
  Then I should see "Name can't be blank"
  When I fill in "team[name]" with "The Condors"
  And I click "Create Team"
  Then I should see "successfully created"
  When I click on "Home"
  And I click on "New team"
  And I fill in "team[name]" with "The Condors"
  And I click "Create Team"
  Then I should see "Name has already been taken"

Scenario: Rename a team
  Given I have a team called "The Kinks"
  When I visit the teams page
  Then I should see "The Kinks"
  And I click on "The Kinks"
  And I click on "Edit this team"
  And I fill in "team[name]" with "The Ramones"
  And I click on "Update Team"
  Then I should see "successfully"
  And I should see "Ramones" within "h1"

Scenario: Disallow removing a team with goals
  Given I have a team called "The Kinks" with an objective to "Save the world"
  And I visit the teams page
  And I click on "The Kinks"
  Then I should see "Save the world"
  When I click on "Edit this team"
  And I click on "Destroy"
  Then I should see "Cannot delete"

Scenario: Nest teams within other teams
  Given I have a team called "The Ramones"
  And I have a team called "Punk Bands"
  When I visit the teams page
  Then I should see "The Ramones"
  When I nest the team "The Ramones" under the team "Punk Bands"
  And I visit the teams page
  Then I should NOT see "The Ramones"
  When I click on "Punk Bands"
  Then I should see "The Ramones"
