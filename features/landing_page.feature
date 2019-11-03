Feature: Landing page
Description: Site visitors should see a landing page with links if they are authorized users

Background: Create users
	Given the following users exist:
	| name  | email               | auth  | admin | id |
	| Chris | chris@berkeley.edu  | true  | true  | 1  |
	| Amy   | amy@berkeley.edy    | true  | false | 2  |
	| Noah  | noah@berkeley.edu   | false | false | 3  |
	| Bette | bette@berkeley.edu  | false | true  | 4  |

Scenario: See the correct links on the landing page as student director
	Given I am logged in as Amy
	Then I should see "Hello, Amy."
	And I should see "View My Schedules"
	And I should see "Academic Calendar"
	And I should not see "View Users"

Scenario: See the correct links on the landing page as admin
	Given I am logged in as Chris
	Then I should see "Hello, Chris."
	And I should see "View My Schedules"
	And I should see "Academic Calendar"
	And I should see "View Users"

Scenario: Link to my schedules
	Given I am logged in as Amy
	And I follow "View My Schedules"
	Then I should be on "/users/2/schedules"

Scenario: Log out and links disappear
	Given I am logged in as Amy
	When I follow "Log Out"
	Then I should be on "/"
	And I should see "Academic Calendar"
	And I should not see "Hello, Amy."
	And I should not see "View My Schedules"
	And I should not see "View Users"

Scenario: Logged in as an unauthorized user
	Given I am logged in as Noah
	Then I should see "Hello, Noah."
	And I should see "Academic Calendar"
	And I should not see "View My Schedules"
	And I should not see "View Users"

