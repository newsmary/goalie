Feature: Search for things.

Background:
    Given I sign in as a non-admin user

@wip
Scenario: Simple search
  Given I have a team called "The Wombats" with an objective to "Git 'er done!"
  And I have a team called "The Mugglewumps" with an objective to "Hold a dance party."
  When I fill_in "q" with "wombats"
  And I click "search"
  Then I should see "wombats" within ".results"
  And I should NOT see "dance" within ".results"
