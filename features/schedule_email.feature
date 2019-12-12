Feature: Notification emails
Description: Admin should receive an update once student directors have submitted their schedules

Background: Create users
	Given the following users exist:
	| name  | email               | auth  | admin | id |
	| Chris | chris@berkeley.edu  | true  | true  | 1  |
	| Amy   | amy@berkeley.edy    | true  | false | 2  |

Scenario: Create a schedule
    Given I am logged in as Amy
    And I am creating a schedule for Amy
    And I select the following times:
    | day    | time | var   |
    | mon    | 1100 | false |
    And I press "Create Schedule"
    Then "chris@berkeley.edu" should receive an email
