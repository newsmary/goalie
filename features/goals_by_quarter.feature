Feature: Allow me to assign goals to a specific quarter and then browse by quarter.

Background:
    Given I've set up the default statuses
    And I sign in as a non-admin user

@wip @time_travel
Scenario: Let me assign an objective to the current or next quarter. But not previous...that would be rewriting history ;)
  Given the current date is 27 Sep 2017
  And I have a team called "GusGus"
  When I visit the team called "GusGus"
  And I click on "Add a new objective"
  Then I should see "Quarter"
  And I should see "Q2 2017/18"
  And I should see "Q3 2017/18"
  And I should see "Q4 2017/18"
  When I click on "Q3 2017/18"
  And I fill in "goal[name]" with "What's the frequency, Kenneth?"
  And I click "Create objective"
  Then I should see "successfully created"
  And I should see "Q3 2017/18"
  And I should see "What's the frequency, Kenneth?"
  When I click on "What's the frequency, Kenneth?"
  And I click on "Add a key result" within ".actions"
  Then I should see "Q3 2017/18"
  #don't see the option to assign the KR to a different quarter from the Objective
  And I should NOT see "Q4 2017/18"
  When I fill in "goal[name]" with "My key result goes here."
  And I click "Create key result"
  Then I should see "successfully"
  And I should see "Q3 2017/18"
