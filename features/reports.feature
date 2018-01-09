Feature: As a user, I'd like a common starting place where I can quickly get an overview of things relevant to me and dive into other areas of the site for more detail.

Background:
    Given I sign in as a non-admin user
    Given I've set up the default statuses

Scenario: See the quarterly reports
  Given I have a team called "The Walruses" with some scored OKRs from last quarter
  And I visit the home page
  And I click on "See goals from last quarter"
  Then I should see "The Walruses"

#@wip
#Scenario: See all goals this quarter across all teams
#  Given I have a team called "The Peaky Blinders" with some scored OKRs from this quarter
#  When I visit the homepage
#  And I click on "All goals this quarter"
#  Then I should see "Peaky"
