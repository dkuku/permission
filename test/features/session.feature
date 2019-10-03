Feature: User session coffee
  User can register
  User can log in
  User can log out

  Scenario: User creates account
    Given I navigate to the index page
    And I click the Sign In link
    Then I should see the Sign up page
