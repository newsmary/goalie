Feature: Test the most basic bits of the app.


Scenario: See "Welcome!" on the homepage.
  When I visit the homepage
  #Then debug
  Then I should see "Welcome!" within "h1"
