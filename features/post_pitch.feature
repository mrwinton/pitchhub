Feature: posting pitch
  As a user, I want to create a pitch so that the community may collaborate on it

  Background:
    Given following users exist:
      | username    | email             |
      | Foo	        | foo@foo.foo       |
      | Bar      	| bar@bar.bar       |
      | Baz      	| baz@baz.baz       |
      | Qux      	| qux@qux.qux       |
    And I sign in as "foo@foo.foo"
    And I create a group called "partners" consisting of:
      | email       |
      | baz@baz.baz |
      | qux@qux.qux |
    And I go to the new pitch page

  Scenario: post well formed pitch card with seek and deselect
    When I fill in the following:
      | Title	        | Energy-saving agriculture innovation  |
      | Overview        | lorem ipsum dolorem                   |
    And I specify the following pitch points:
      | opportunity     | High energy costs involved in running agriculture business could be decreased       |
      | solution        | A cost-effective innovation that uses renewable energy in the agriculture industry  |
    And I seek the following pitch points:
      | resources       |
      | facilitation    |
    And I deselect the following pitch points:
      | voting          |
    And I set the scope of disclosure with the criteria:
      | Scope Type      | Operation Type        | Value         |
      | Geography       | Include               | New Zealand   |
      | User            | Exclude               | bar@bar.bar   |
    And I set my profile visibility with the criteria:
      | Scope Type      | Operation Type        | Value         |
      | Group           | Include               | partners      |
    And I submit the pitch card
    Then I should see "Success"
