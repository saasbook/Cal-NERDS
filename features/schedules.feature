Feature: Add and create schedules
Description: Users should be able to create and update schedules

Background: Logged in as Student Director
    Given I am logged in as a student director
    And I go to the schedule page

Scenario: Create a schedule
    Given I select the following times:
    | day  | time     |
    | M    | 11:00 AM |
    | M    | 11:30 AM |
    | M    | 12:00 PM |
    | M    | 12:30 PM |
    | W    | 11:00 AM |
    | R    | 04:00 PM |
    And I submit the schedule # TODO: remove below step
    Given I have created a schedule with the following times:
    | day  | time     |
    | M    | 11:00 AM |
    | M    | 11:30 AM |
    | M    | 12:00 PM |
    | M    | 12:30 PM |
    | W    | 11:00 AM |
    | R    | 04:00 PM |
    And I should have the following schedule:
    | day  | time     |
    | M    | 11:00 AM |
    | M    | 11:30 AM |
    | M    | 12:00 PM |
    | M    | 12:30 PM |
    | W    | 11:00 AM |
    | R    | 04:00 PM |

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
    | day  | time     |
    | M    | 11:00 AM |
    | M    | 11:30 AM |
    | M    | 12:00 PM |
    | M    | 12:30 PM |
    | W    | 11:00 AM |
    | R    | 04:00 PM |
    When I update the schedule with the following:  # this will toggle each of the below, so M 11 AM will be removed
    | day  | time     |
    | M    | 11:00 AM |
    | F    | 1:00 PM  |
    | R    | 04:30 PM  |
    And I submit the schedule
    Then I should have the following schedule:
    | day  | time     |
    | M    | 11:30 AM |
    | M    | 12:00 PM |
    | M    | 12:30 PM |
    | W    | 11:00 AM |
    | R    | 04:00 PM  |
    | R    | 04:30 PM  |
    | F    | 01:00 PM  |

Scenario: Remove all times from a schedule
    Given I have created a schedule with the following times:
    | day  | time     |
    | M    | 11:30 AM |
    | M    | 12:00 PM |
    | M    | 12:30 PM |
    | W    | 11:00 AM |
    | R    | 04:00 PM  |
    | R    | 04:30 PM  |
    | F    | 01:00 PM  |
    When I update the schedule with the following:
    | day  | time     |
    | M    | 11:30 AM |
    | M    | 12:00 PM |
    | M    | 12:30 PM |
    | W    | 11:00 AM |
    | R    | 04:00 PM  |
    | R    | 04:30 PM  |
    | F    | 01:00 PM  |
    And I submit the schedule
    Then I should have the following schedule:
    | day  | time     |