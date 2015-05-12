Feature: annotate pitch
  As a user, I want to suggest changes on viewable pitches so that I can offer insight

  Background:
    Given following users exist:
      | username    | email             |
      | Foo	        | foo@foo.foo       |
      | Bar      	| bar@bar.bar       |
    And a user with email "foo@foo.foo" posts a well formed pitch

  Scenario: suggest a change
    When I sign in as "bar@bar.bar"
    And I am on the pitch card's page
    And I click "suggest change" on the pitch point "solve"
    And I fill in the following:
      | change              | my suggested change                   |
      | comment             | reasoning for my change suggestion    |
    And I set the scope of disclosure with the criteria:
      | Scope Type      | Operation Type        | Value         |
      | Geography       | Include               | New Zealand   |
      | User            | Exclude               | bar@bar.bar   |
    And I set my profile visibility with the criteria:
      | Scope Type      | Operation Type        | Value         |
      | User            | Include               | me            |
    And I press "Submit"
    Then I should see "my suggested change" within ".change"
    And I should see "reasoning for my change suggestion" within ".change comment"
    And I should see "less than a minute ago" within ".change time"
    And I should see "to be reviewed" within ".change status"


  Scenario: delete an annotation
#    When I sign in as "bar@bar.bar"
#    And I am on the pitch's page with title "baz"
#    When I focus the annotate field
#    And I fill in the following:
#      | text            | barannotation    |
#    And I press "Submit"
#    Then I should see "barannotation"
#    When I comment "bar2annotation" on "barannotation"
#    And I click to delete the first annotation
#    And I confirm the alert
#    Then I should not see "bar2annotation"