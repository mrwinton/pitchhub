Feature: change password
  As a user, I want to change my password so that I can keep my account secure

  Scenario: Change my password
    Given I am signed in
    When I go to the users edit page
    And I fill out change password section with my password and "newsecret" and "newsecret"
    And I press "Change password"
    Then I should see "Password changed"
    Then I should be on the new user session page
    When I sign in with password "newsecret"
    Then I should be on the stream page

  Scenario: Attempt to change my password with invalid input
    Given I am signed in
    When I go to the edit user page
    And I fill out change password section with my password and "too" and "short"
    And I press "Change password"
    Then I should see "Password change failed"
    And I should see "Password is too short"
    And I should see "Password confirmation doesn't match"

  Scenario: Reset my password
    Given a user named "Foo" with email "foo@foo.foo"
    Given I am on forgot password page
    When I fill out forgot password form with "foo@foo.foo"
    And I submit forgot password form
    Then I should see "You will receive an email with instructions"
    When I follow the "Change my password" link from the last sent email
    When I fill out reset password form with "supersecret" and "supersecret"
    And I submit reset password form
    Then I should be on the stream page
    And I sign out manually
    And I sign in manually as "foo" with password "supersecret"
    Then I should be on the stream page

  Scenario: Attempt to reset password with invalid password
    Given a user named "Foo" with email "foo@foo.foo"
    Given I am on forgot password page
    When I fill out forgot password form with "ffoo@foo.foo"
    And I submit forgot password form
    When I follow the "Change my password" link from the last sent email
    When I fill out reset password form with "too" and "short"
    And I press "Change my password"
    Then I should be on the user password page
    And I should see "Password is too short"
    And I should see "Password confirmation doesn't match"

  Scenario: Attempt to reset password with invalid email
    Given I am on forgot password page
    When I fill out forgot password form with "notanemail"
    And I submit forgot password form
    Then I should see "No account with this email exists"