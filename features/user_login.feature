Feature: User login
  In order to access the site
  the user
  wants to login with login and password

  Background:
    Given a user with the login "homer" exists

  Scenario: User login
    Given I go to the homepage
    And I follow "Log In"
    And I fill in "Login" with "homer"
    And I fill in "Password" with "simpson312"
    When I press "Submit"
    Then I should be on the account page
    And I should see "Login successful!"
    And I should see "Login"
    And I should see "Email"
    When I follow "Edit"
    Then I should see "Edit My Account"
