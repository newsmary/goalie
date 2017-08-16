Feature: As a user, I need a way to share progress and issues so that other teams and stakeholders can easily see what's going on with my goals.

Background:
    Given I sign in as a non-admin user

Scenario: Report progress on a goal
  Given I've set up the default statuses
  Given I have a team called "The Buzzards" with an objective to "Have a house party"
  And the objective "Have a house party" has a key result "Distill spirits"
  When I visit the objective called "Distill spirits"
  Then I should see
  And I have a team called "The Buzzkills" with an objective to "Go to bed early"
  When I visit the objective called "Have a house party"
  And I click on "Add to favourites"
  Then I should see "Successfully added"
  When I visit the home page
  Then I should see "house party" within ".results"
  When I click on "house party"
  And I click on "Remove from favourites"
  Then I should see "Successfully removed"
  When I visit the home page
  Then I should NOT see "house party" within ".results"
