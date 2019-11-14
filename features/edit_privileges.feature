Feature: Admins should be able to edit user privileges

Background: Create users
	Given the following users exist:
	| name  | email               | auth  | admin | id |
	| Chris | chris@berkeley.edu  | true  | true  | 1  |
	| Amy   | amy@berkeley.edy    | true  | false | 2  |
	| Noah  | noah@berkeley.edu   | false | false | 3  |
	| Bette | bette@berkeley.edu  | false | true  | 4  |

Scenario: Admin should see 
	Given I am logged in as Chris
	And I am on "/users"
	Then I should see the checkboxes:
	| name  | auth_checked | admin_checked |
	| Chris | true         | true          |
	| Amy   | true         | false         |
	| Noah  | false        | false         |
	| Bette | false        | true          |

Scenario: Change Noah to auth user
	Given I am logged in as Chris
	And I am on "/users"
	When I check Noah's auth
	And I follow Noah's "Update User"
	Then Noah should be an auth

Scenario: Change Amy to admin
	Given I am logged in as Chris
	And I am on "/users"
	When I check Amy's admin
	And I follow Amy's "Update User"
	Then Amy should be an admin

Scenario: An admin cannot un-admin themselves
	Given I am logged in as Chris
	And I am on "/users"
	Then I should not be able to uncheck Chris's admin

Scenario: Admin && !(Auth) should not be able to edit permissions or see users
	Given I am logged in as Bette
	When I go to "/users"
	Then I should be redirected to "/"
