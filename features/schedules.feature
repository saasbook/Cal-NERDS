Feature: Add and create schedules
Description: Users should be able to create and update schedules

Background: Logged in as Student Director
    Given I am logged in as a student director
    And I go to the schedule page

Scenario: Create a schedule
    Given I select the following times:
    | day    | time |
    | mon    | 1100 |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600|
    And I submit the schedule # TODO: remove below step
    Given I have created a schedule with the following times:
    | day    | time |
    | mon    | 1100 |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |
    And I should have the following schedule:
    | day    | time |
    | mon    | 1100 |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |

Scenario: Create an empty schedule
    When I select the following times:
    | day | time |
    And I submit the schedule # TODO: remove below step
    Then I have created a schedule with the following times:
    | day | time |
    And I should have the following schedule:
    | day | time |

Scenario: Update an existing schedule
    Given I have created a schedule with the following times:
    | day    | time |
    | day    | time |
    | mon    | 1100 |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |
    When I update the schedule with the following:  # this will toggle each of the below, so M 11 AM will be removed
    | day    | time |
    | mon    | 1100 |
    | fri    | 1300 |
    | thu    | 1630 |
    And I submit the schedule
    Then I should have the following schedule:
    | day    | time |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |
    | thu    | 1630 |
    | fri    | 1300 |

Scenario: Remove all times from a schedule
    Given I have created a schedule with the following times:
    | day    | time |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |
    | thu    | 1630 |
    | fri    | 1300 |
    When I update the schedule with the following:
    | day    | time |
    | mon    | 1130 |
    | mon    | 1200 |
    | mon    | 1230 |
    | wed    | 1100 |
    | thu    | 1600 |
    | thu    | 1630 |
    | fri    | 1300 |
    And I submit the schedule
    Then I should have the following schedule:
    | day  | time     |
