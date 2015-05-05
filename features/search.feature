Feature: search for users and hashtags
  As a user, I want to use specific terms or phrases to search so that I may find ideas that interest me

  Background:
    Given following users exist:
      | username    | email             |
      | Foo	        | foo@foo.foo       |
      | Bar      	| bar@bar.bar       |
    And I sign in as "foo@foo.foo"

    @wip

  Scenario: search a term
    When I enter "science" in the search input
    Then I should see "science within ".ac_even"

  Scenario: search for a nonexistent term
    When I enter "gobble-de-gook" in the search input
    Then I should see "gobble-de-gook" within ".ac_even"

