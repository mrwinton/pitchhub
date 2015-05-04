Feature: edit profile
  As a user, I want to edit my profile so that the recommender is more accurate

  Scenario: editing profile fields
    Given I am signed in
    And I go to the edit profile page

    When I fill in the following:
      | first_name         | Foo             |
      | last_name          | Bar             |
      | interests          | science         |
      | location           | Wellington      |

    And I press "update"

    Then I should be on my edit profile page
    And I should see a flash message indicating success
    And the "first_name" field should contain "Foo"
    And the "last_name" field should contain "Bar"
    And the "interests" field should contain "science"
    And the "location" field should be filled with "Wellington"