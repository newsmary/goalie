Feature: As a user, I need a way to share progress and issues so that other teams and stakeholders can easily see what's going on with my goals.

Background:
    Given I sign in as a non-admin user
    Given I've set up the default statuses

Scenario: See a new goal with a "0%" and then make an update
  And I have a team called "The Buzzards" with an objective to "Have a house party"
  And the objective "Have a house party" has a key result "Slice lime wedges"
  When I visit the objective called "Slice lime wedges"
  Then I should see "0%"
  When I click on "Report progress"
  And I fill in "score[amount]" with "20"
  And I click on "On track"
  And I fill in "score[reason]" with "Sliced 1 out of 5 limes."
  And I click on "Save"
  Then I should see "20%"
  #And I should see "20"
