Feature: Test the most basic bits of the app.


Scenario: See "Welcome" on the homepage.
  Given I am on the homepage
  Then I should see "Welcome" within "H1"