# Feature: Add and create schedules
# Description: Users should be able to create and update schedules

# Background: Logged in as Student Director
#     Given I am logged in as a student director

# Scenario: Create a schedule
#     When I select the following times:
#     | day  | time     |
#     | M    | 11:00 AM |
#     | M    | 11:30 AM |
#     | M    | 12:00 PM |
#     | M    | 12:30 PM |
#     | W    | 11:00 AM |
#     | R    | 4:00 PM |
#     Then I should have another schedule
#     And it should have the correct times

# Scenario: Create an empty schedule
#     When I select the following times:
#     | day | time |
#     Then I should have another schedule
#     And it should have no times

# Scenario: Update an existing schedule
#     Given I have created a schedule with the following times:
#     | day  | time     |
#     | M    | 11:00 AM |
#     | M    | 11:30 AM |
#     | M    | 12:00 PM |
#     | M    | 12:30 PM |
#     | W    | 11:00 AM |
#     | R    | 4:00 PM |
#     When I update the schedule:  # this will toggle each of the below, so M 11 AM will be removed
#     | day  | time     |
#     | M    | 11:00 AM |
#     | F    | 1:00 PM  |
#     | R    | 4:30 PM  |
#     Then my schedule should have the following times:
#     | day  | time     |
#     | M    | 11:30 AM |
#     | M    | 12:00 PM |
#     | M    | 12:30 PM |
#     | W    | 11:00 AM |
#     | R    | 4:00 PM  |
#     | R    | 4:30 PM  |
#     | F    | 1:00 PM  |

# Scenario: Remove all times from a schedule
#     Given I have a schedule with the following times:
#     | day  | time     |
#     | M    | 11:30 AM |
#     | M    | 12:00 PM |
#     | M    | 12:30 PM |
#     | W    | 11:00 AM |
#     | R    | 4:00 PM  |
#     | R    | 4:30 PM  |
#     | F    | 1:00 PM  |
#     When I update the schedule:
#     | day  | time     |
#     | M    | 11:30 AM |
#     | M    | 12:00 PM |
#     | M    | 12:30 PM |
#     | W    | 11:00 AM |
#     | R    | 4:00 PM  |
#     | R    | 4:30 PM  |
#     | F    | 1:00 PM  |
#     Then my schedule should have the following times:
#     | day  | time     |