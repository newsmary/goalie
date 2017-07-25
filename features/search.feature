Feature: Search for things.

Background:
    Given I sign in as a non-admin user

@wip
Scenario: Simple search
  Given I have a team called "The Wombats" with an objective to "Git 'er done!"
  When I search for "wombats"
  #When I fill_in "q" with "wombats"
  #And I click "search"
  Then I should see "wombats" within ".results"
