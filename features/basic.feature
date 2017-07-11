Feature: Test the most basic bits of the app.


Scenario: See "About" on the "About" page.
  When I visit the homepage
  And I click on About
  #Then debug
  Then I should see "Welcome!" within "h1"
