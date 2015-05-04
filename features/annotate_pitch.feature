Feature: annotate pitch
  As a user, I want to suggest changes on viewable pitches so that I can offer insight

  Background:
    Given following users exist:
      | username    | email             |
      | Foo	        | foo@foo.foo       |
      | Bar      	| bar@bar.bar       |
    And a user with email "foo@foo.foo" posts a pitch with title "baz"

  Scenario: add an annotation
    When I sign in as "bar@bar.bar"
    And I am on the pitch's page with title "baz"
    When I focus the annotate field
    And I fill in the following:
      | text            | barannotation    |
    And I press "Submit"
    Then I should see "barannotation" within ".annotation"
    And I should see "less than a minute ago" within ".annotation time"

  Scenario: delete an annotation
    When I sign in as "bar@bar.bar"
    And I am on the pitch's page with title "baz"
    When I focus the annotate field
    And I fill in the following:
      | text            | barannotation    |
    And I press "Submit"
    Then I should see "barannotation"
    When I comment "bar2annotation" on "barannotation"
    And I click to delete the first annotation
    And I confirm the alert
    Then I should not see "bar2annotation"