Feature: As a user, I need a way to share progress and issues so that other teams and stakeholders can easily see what's going on with my goals.

Background:
    Given I sign in as a non-admin user
    And I've set up the default statuses
    And I have a team called "Peter Gabriel" with an objective to "Shock the monkey"
    And I visit the goal called "Shock the monkey"


Scenario: See "not started" for new goals
  Then I should see "Not started"

Scenario: Update a new goal and see the progress. Also test that I can edit the update after the fact.
  When I click on "Report progress"
  And I fill in "score[amount]" with "20"
  #have to fill this in...
  And I fill in "score[confidence]" with "30"
  And I fill in "score[reason]" with "I've started."
  And I click on "Save"
  Then I should see "20%"
  And I should see "In progress"
  #now edit it
  When I click on "Edit" within ".edit_score_link"
  And I should see "Edit progress update"
  And I fill in "score[reason]" with "My updated narrative"
  And I click "Save"
  Then I should see "My updated narrative"
  #TODO: show that there is NO edit button if I'm not the owner



@javascript
Scenario: Prompt to fill in "Lessons learned" when marking a goal as complete or cancelled.
  When I click on "Report progress"
  #weird, phantomjs fails to find "Complete" if I dont' wait a second or two
  And I wait 1 second
  And I click on "Finished"
  Then I should see "Lessons learned"
  When I click "Save"
  Then I should see "Please share what you've learned by working on this"
  When I fill in "score[learnings]" with "We learned so much."
  And I fill in "score[reason]" with "Here are some reasons why we gave this goal this score."
  And I fill in "score[amount]" with "25"
  #required now
  And I fill in "score[confidence]" with "100"
  And I click "Save"
  Then I should see "Successfully"
  And I should see "We learned so much"

@javascript
Scenario: Form validation
  And I click on "Report progress"
  #weird, phantomjs fails to find "Complete" if I don't wait a second or two
  And I wait 1 second
  And I fill in "score[amount]" with ""
  And I click "Save"
  Then I should see "required" within ".error"
  When I fill in "score[amount]" with "23592385092835"
  And I click "Save"
  Then I should see "colossal" within ".error"
  When I fill in "score[amount]" with "25"
  And I fill in "score[reason]" with ""
  And I click "Save"
  Then I should see "Please describe" within ".error"
  And I fill in "score[reason]" with "Things are going great."
  And I click "Save"
  #for the confidence
  Then I should see "required" within ".error"
  When I fill in "score[confidence]" with "80"
  And I click "Save"
  Then I should see "Successfully"
  And I should see "going great."
