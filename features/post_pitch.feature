Feature: posting pitch
  As a user, I want to create a pitch so that the community may collaborate on it

  Background:
    Given following users exist:
      | username    | email             |
      | Foo	        | foo@foo.foo       |
      | Bar      	| bar@bar.bar       |
    And I sign in as "foo@foo.foo"
    And I go to the new pitch page

  @wip
  Scenario: post a text-only pitch

  Scenario: post a pitch with text and an image

  Scenario: post a pitch with text and an image

  Scenario: back out of posting a pitch