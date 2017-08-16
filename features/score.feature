Feature: As a user, I need a way to share progress and issues so that other teams and stakeholders can easily see what's going on with my goals.

Background:
    Given I sign in as a non-admin user

@wip
Scenario: See a new goal with a status of "not started"
  Given I've set up the default statuses
  And I have a team called "The Buzzards" with an objective to "Have a house party"
  And the objective "Have a house party" has a key result "Distill spirits"
  When I visit the objective called "Distill spirits"
  Then I should see "Not started"
