Feature: Let people link goals together.

Background:
    Given I sign in as a non-admin user
    Given I've set up the default statuses

Scenario: Link a couple of objectives to a primary objective
  Given I have a team called "The Zombies" with an objective to "Eat brains!"
  And I have a team called "Ninjas" with an objective to "Be sneaky!"
  And I have a team called "Tortoise" with an objective to "Walk 5% faster."
  When I visit the goal called "Eat brains!"
  Then I should NOT see "See related goals"
  When I click "Link this objective to another goal"
  Then I should see "Eat brains!"
  When I fill in "related_name" with "sneaky"
  And I click "Search" within ".big_form"
  #And I wait 1 second
  Then I should see "Be sneaky!"
  And I should see "Ninjas"
  When I click on "Link to this objective" within ".results"
  Then I should see "successfully"
  When I click "1 linked goal"
  Then I should see "Be sneaky!" within ".results"
  When I click "Create a new link" within ".actions"
  #search in lower case...
  When I fill in "related_name" with "walk"
  And I click "Search" within ".big_form"
  Then I should see "Tortoise" within ".results"
  When I click "Link to this" within ".results"
  And I click "2 linked goals"
  #case sensitive, obj name is title case :)
  Then I should see "Walk" within ".results"
