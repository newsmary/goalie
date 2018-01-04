Feature: As a user, I'd like a common starting place where I can quickly get an overview of things relevant to me and dive into other areas of the site for more detail.

Background:
    Given I sign in as a non-admin user
    Given I've set up the default statuses

@wip
Scenario: See the quarterly reports
  Given I have a team called "The Walruses" with some scored OKRs from the last quarter
  And I visit the home page
  And I click on "See results from last quarter"
  Then I should see "The Walruses"
