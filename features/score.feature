Feature: As a user, I need a way to share progress and issues so that other teams and stakeholders can easily see what's going on with my goals.

Background:
    Given I sign in as a non-admin user
    And I've set up the default statuses

Scenario: See a new goal with no percentage and then make an update. Also test that I can edit the update after the fact.
  And I have a team called "The Buzzards" with an objective to "Have a house party"
  And the objective "Have a house party" has a key result "Slice lime wedges"
  When I visit the objective called "Slice lime wedges"
  #right now, unstarted goals don't show anything...
  #Then I should see "0%"
  When I click on "Report progress"
  #And I click "Save"
  #Then I should see "cannot"
  And I fill in "score[amount]" with "20"
  #have to fill this in...
  And I fill in "score[confidence]" with "30"
  And I click on "In progress"
  And I fill in "score[reason]" with "Sliced 1 out of 5 limes."
  And I click on "Save"
  Then I should see "20%"
  #And I should see "20"
  #now edit it
  When I click on "Edit" within ".edit_score_link"
  And I should see "Edit progress update"
  And I fill in "score[reason]" with "My updated narrative"
  And I click "Save"
  Then I should see "My updated narrative"
  #TODO: show that there is NO edit button if I'm not the owner



@javascript
Scenario: Prompt to fill in "Lessons learned" when marking a goal as complete or cancelled.
  Given I have a team called "The Windowlickers" with an objective to "Shock Saatchi"
  And the objective "Shock Saatchi" has a key result "Paint 5 murals"
  When I visit the goal called "Paint 5 murals"
  And I click on "Report progress"
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
  Given I have a team called "Peter Gabriel" with an objective to "Shock the monkey"
  When I visit the goal called "Shock the monkey"
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
