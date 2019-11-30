Feature: Reminder emails
Description: Student directors should receive reminders to submit their schedules on Friday

Background: Create users
	Given the following users exist:
	| name  | email               | auth  | admin | id |
	| Chris | chris@berkeley.edu  | true  | true  | 1  |
	| Amy   | amy@berkeley.edu    | true  | false | 2  |

Scenario: No schedule
    Given it is currently 2019-11-29 11:59
    Then "amy@berkeley.edu" should have no emails
    #Given it is currently 2019-11-29 13:01
    #Then "amy@berkeley.edu" should receive an email with subject "Reminder to fill out schedules"
