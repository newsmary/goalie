Feature: A nice looking wall-board that shows the realtime status of everything.

Background:
    Given I sign in as an admin user
    Given I've set up the default statuses

Scenario: Create goals and show wallboard
  Given I set up some demo data
  And I visit team "Protons"
  And I click "View wallboard"
  Then I should see "Protons"
  And I should see "Be Massively Awesome"
  And I should see "On track"

#TODO: a scenario that tests updating data based on an import
Scenario: Import goals & scores
  When I import teams
  And I import people
  When I import statuses
  And I import goals
  Then I should see "Successfully imported"
  And I import scores
  Then I should see "Successfully imported"
  When I click on "Admin"
  And I visit "/statuses"
  Then I should see "In progress" within "td" 1 time
  When I import statuses
  And I import goals
  Then I should see "Successfully imported"
  And I import scores
  And I visit "/statuses"
  Then I should see "In progress" within "td" 1 time


  #now look at the data.
  When I click "Teams" within ".nav"
  Then I should see "Team A"
  And I should see "Team B"
  When I click "Team A"
  And I click on "Team A1"
  And I click on "peanut"
  And I click on "An apple"
  Then I should see "apple detail"
  And I should see "80%"
  And I should see "Delicious"
  And I should see "Suzy Admin" within ".hint"
  When I click on "Team A"
  And I click on "banana"
  And I click on "grape"
  And I click on "See all progress"
  Then I should see "Delicious grapes"
  And I should see "Cindy Williams" within ".small"
