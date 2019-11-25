@javascript
Feature: Schedules have variable and fixed times
Description: Users should be able to create and update schedules with variable times

Background: Logged in as Student Director
    Given the following users exist:
    | name  | email               | auth  | admin | id |
    | Chris | chris@berkeley.edu  | true  | true  | 1  |
    | Amy   | amy@berkeley.edy    | true  | false | 2  |
    | Noah  | noah@berkeley.edu   | false | false | 3  |
    | Bette | bette@berkeley.edu  | false | true  | 4  |
    # And I am logged in as Amy
    # And I am viewing the schedule page for Amy

Scenario: Student director creates a schedule with variable hours
    Given I am logged in as Amy
    And I am creating a schedule for Amy
    And I select the following times:
    | day    | time | var   |
    | mon    | 1100 | false |
    | mon    | 1130 | false |
    | mon    | 1200 | false |
    | tue    | 1100 | true  |
    | tue    | 1130 | true  |
    | mon    | 1230 | false |
    | wed    | 1100 | false |
    | thu    | 1600 | false |
    | tue    | 1200 | true  |
    | tue    | 1230 | true  |
    And I press "Create Schedule"
    Then Amy should have the following schedule:
    | day    | time | var   |
    | mon    | 1100 | false |
    | mon    | 1130 | false |
    | mon    | 1200 | false |
    | mon    | 1230 | false |
    | wed    | 1100 | false |
    | thu    | 1600 | false |
    | tue    | 1100 | true  |
    | tue    | 1130 | true  |
    | tue    | 1200 | true  |
    | tue    | 1230 | true  |

Scenario: Update an existing schedule
    Given I am logged in as Amy
    And I have created a schedule with the following times for Amy:
    | day    | time | var   |
    | mon    | 1100 | true  |
    | mon    | 1130 | true  |
    | mon    | 1200 | false |
    | mon    | 1230 | false |
    | wed    | 1100 | false |
    | thu    | 1600 | true  |
    When I update Amy's schedule with the following:
    | day    | time | var   |
    | mon    | 1100 | true  |
    | mon    | 1130 | false |
    | fri    | 1300 | true  |
    | thu    | 1630 | false |
    And I press "Update Schedule"
    Then Amy should have the following schedule:
    | day    | time | var   |
    | mon    | 1130 | false |
    | mon    | 1200 | false |
    | mon    | 1230 | false |
    | wed    | 1100 | false |
    | thu    | 1600 | true  |
    | thu    | 1630 | false |
    | fri    | 1300 | true  |
