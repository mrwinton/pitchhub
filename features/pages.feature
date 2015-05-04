Feature: pages load
  As a user, I want pages to load so I may view them
  Background:
    Given following users exist:
    | username    | email             |
    | Foo	      | foo@foo.foo       |
    | Bar      	  | bar@bar.bar       |

  @wip
  #index
  Scenario: index as guest
    Given I am not signed in
    And I go to the index page
    Then I should not see "404"

  Scenario: index as member
    Given I am signed in
    And I go to the index page
    Then I should not see "404"

  #deck (activity stream)
  Scenario: deck
    Given I am signed in
    And I go to the deck page
    Then I should not see "404"

  Scenario: deck as guest
    Given I am not signed in
    And I go to the deck page
    Then I should see the login page

  #card/<pitchkey>
  Scenario: pitch with correct id
    Given I am signed in
    And there is a pitch with id "123"
    And I go to the pitch page with id "123"
    Then I should not see "404"

  #card
  Scenario: new pitch
    Given I am signed in
    And I go to the create pitch page
    Then I should not see "404"

  #member/<member_id>
  Scenario: member's profile exists
    Given I am signed in
    And I go to the member page with id "Foo"
    Then I should not see "404"

  Scenario: member's profile does not exists
    Given I am signed in
    And I go to the member page with id "aasdasd"
    Then I should see "404"

  Scenario: member's profile as guest
    Given I am not signed in
    And I go to the member page with id "Foo"
    Then I should see the login page

    #login
  Scenario: login as guest
    Given I am not signed in
    And I go to the login page
    Then I should see the login page

  Scenario: login as member
    Given I am signed in
    And I go to the login page
    Then I should see the index page

        #join
  Scenario: join as guest
    Given I am not signed in
    And I go to the join page
    Then I should see the join page

  Scenario: join as member
    Given I am signed in
    And I go to the join page
    Then I should see the index page