@javascript
Feature: Add and create schedules
Description: Users should be able to create and update schedules

Background: Logged in as Student Director
    Given the following users exist:
    | name  | email               | auth  | admin | id |
    | Chris | chris@berkeley.edu  | true  | true  | 1  |
    | Amy   | amy@berkeley.edy    | true  | false | 2  |
    | Noah  | noah@berkeley.edu   | false | false | 3  |
    | Bette | bette@berkeley.edu  | false | true  | 4  |
    # And I am logged in as Amy
    # And I am viewing the schedule page for Amy

Scenario: Create a schedule
    Given I am logged in as Amy
    And I am creating a schedule for Amy
    And I select the following times:
    | day    | time | var   |
    | mon    | 1100 | false |
    | mon    | 1130 | false |
    | mon    | 1200 | false |
    | mon    | 1230 | false |
    | wed    | 1100 | false |
    | thu    | 1600 | false |
    And I press "Create Schedule"
    Then Amy should have the following schedule:
    | day    | time | var   |
    | mon    | 1100 | false |
    | mon    | 1130 | false |
    | mon    | 1200 | false |
    | mon    | 1230 | false |
    | wed    | 1100 | false |
    | thu    | 1600 | false |

Scenario: Create an empty schedule
    Given I am logged in as Amy
    And I am creating a schedule for Amy
    And I select the following times:
    | day    | time | var   |
    And I press "Create Schedule"
    Then Amy should have the following schedule:
    | day    | time | var   |

Scenario: Update an existing schedule
    Given I am logged in as Amy
    And I have created a schedule with the following times for Amy:
    | day    | time | var   |
    | mon    | 1100 | false |
    | mon    | 1130 | false |
    | mon    | 1200 | false |
    | mon    | 1230 | false |
    | wed    | 1100 | false |
    | thu    | 1600 | false |
    When I update Amy's schedule with the following:
    | day    | time | var   |
    | mon    | 1100 | false |
    | fri    | 1300 | false |
    | thu    | 1630 | false |
    And I press "Update Schedule"
    Then Amy should have the following schedule:
    | day    | time | var   |
    | mon    | 1130 | false |
    | mon    | 1200 | false |
    | mon    | 1230 | false |
    | wed    | 1100 | false |
    | thu    | 1600 | false |
    | thu    | 1630 | false |
    | fri    | 1300 | false |

Scenario: Remove all times from a schedule
    Given I am logged in as Amy
    And I have created a schedule with the following times for Amy:
    | day    | time | var   |
    | mon    | 1130 | false |
    | mon    | 1200 | false |
    | mon    | 1230 | false |
    | wed    | 1100 | false |
    | thu    | 1600 | false |
    | thu    | 1630 | false |
    | fri    | 1300 | false |
    When I update Amy's schedule with the following:
    | day    | time | var   |
    | mon    | 1130 | false |
    | mon    | 1200 | false |
    | mon    | 1230 | false |
    | wed    | 1100 | false |
    | thu    | 1600 | false |
    | thu    | 1630 | false |
    | fri    | 1300 | false |
    And I press "Update Schedule"
    Then Amy should have the following schedule:
    | day  | time     | var   |
