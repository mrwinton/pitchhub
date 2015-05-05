Feature: notifications
  As a user, I want to recieve notifications on pitches I am interested/active on

  Background:
    Given following users exist:
      | username    | email             |
      | Foo	        | foo@foo.foo       |
      | Bar      	| bar@bar.bar       |
    And a user with email "foo@foo.foo" posts a pitch with title "baz"

  Scenario: someone annotates my pitch
    Given I sign in as "foo@foo.foo"
    And user "bar@bar.bar" adds an annotation to the pitch with title "baz"
    Then I should see 1 notification

  Scenario: someone accepts my annotation
    Given I sign in as "bar@bar.bar"
    And I add an annotation to the pitch with title "baz"
    And my pitch is accepted
    Then I should see 1 notification

  @wip
  Scenario: scrollbar shows up when >5 notifications

  Scenario: dropdown will load more elements when bottom is reached
