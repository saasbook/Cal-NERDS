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
    And I am logged in as Amy
    And I am viewing the schedule page for Amy

Scenario: Create a schedule
    Given I am creating a schedule for Amy
    And I select the following times:
    | day    | time |
    | mon    | 1100 |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |
    And I press "Create Schedule"
    Then Amy should have the following schedule:
    | day    | time |
    | mon    | 1100 |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |

Scenario: Create an empty schedule
    Given I am creating a schedule for Amy
    And I select the following times:
    | day | time |
    And I press "Create Schedule"
    Then Amy should have the following schedule:
    | day | time |

Scenario: Update an existing schedule
    Given I have created a schedule with the following times for Amy:
    | day    | time |
    | mon    | 1100 |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |
    When I update Amy's schedule with the following:
    | day    | time |
    | mon    | 1100 |
    | fri    | 1300 |
    | thu    | 1630 |
    And I press "Update Schedule"
    Then Amy should have the following schedule:
    | day    | time |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |
    | thu    | 1630 |
    | fri    | 1300 |

Scenario: Remove all times from a schedule
    Given I have created a schedule with the following times for Amy:
    | day    | time |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |
    | thu    | 1630 |
    | fri    | 1300 |
    When I update Amy's schedule with the following:
    | day    | time |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |
    | thu    | 1630 |
    | fri    | 1300 |
    And I press "Update Schedule"
    Then Amy should have the following schedule:
    | day  | time     |
