# Feature: Reminder emails
# Description: Student directors should receive reminders to submit their schedules on Friday

# Background: Create users
# 	Given the following users exist:
# 	| name  | email               | auth  | admin | id |
# 	| Chris | chris@berkeley.edu  | true  | true  | 1  |
# 	| Amy   | amy@berkeley.edu    | true  | false | 2  |

# Scenario: No schedule and before reminder time
#     Given it is currently 2019-11-29 11:59:00 -0800
#     Then "amy@berkeley.edu" should have no emails

# Scenario: No schedule and set to reminder time
#     Given it is currently 2019-11-29 11:59:59 -0800
#     When I wait for 2 secs
#     Then "amy@berkeley.edu" should receive an email with subject "Reminder to fill out schedules"
