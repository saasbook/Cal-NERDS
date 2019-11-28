@javascript
Feature: Admin schedules view
Description: Admins should be able to look at schedule overview of all directors for each week

Background: Logged in as Student Director
    Given the following users exist:
    | name  | email               | auth  | admin | id |
    | Chris | chris@berkeley.edu  | true  | true  | 1  |
    | Amy   | amy@berkeley.edu    | true  | false | 2  |
    | Bette | dane@berkeley.edu   | true  | false | 3  |
    And I am logged in as Chris
    And I am on "/"

# Helpful to have visual feedback, otherwise user may think something isn't working
Scenario: Viewing empty schedule overview page
  And there are no schedules in the database
  And I am on "/schedules/overview"
  Then I should see "No schedules have been added."
  
Scenario: Viewing schedule overview
  Given I have created a schedule with the following times for Amy:
    | day    | time |
    | mon    | 1000 |
    | tue    | 1000 |
    | wed    | 1000 |
    | thu    | 1000 |
    | fri    | 1600 |
  And I have created a schedule with the following times for Bette:
    | day    | time |
    | tue    | 1000 |
    | wed    | 1000 |
    | wed    | 1100 | 
    | wed    | 1200 |
    | thu    | 1000 |
  And I am on "/schedules/overview"
  Then I should not see "No schedules have been added."
  And I should see the following times for "Amy":
    | day    | time |
    | mon    | 1000 |
    | tue    | 1000 |
    | wed    | 1000 |
    | thu    | 1000 |
    | fri    | 1600 |
  And I should see the following times for "Bette":
    | day    | time |
    | tue    | 1000 |
    | wed    | 1000 |
    | wed    | 1100 |
    | wed    | 1200 |
    | thu    | 1000 |

Scenario: Page updates when schedule is changed
  Given I have created a schedule with the following times for Amy:
    | day    | time |
    | mon    | 1000 |
    | tue    | 1000 |
    | wed    | 1000 |
    | thu    | 1000 |
    | fri    | 1600 |
  And I have created a schedule with the following times for Bette:
    | day    | time |
    | tue    | 1000 |
    | wed    | 1000 |
    | wed    | 1100 |
    | wed    | 1200 |
    | thu    | 1000 |
  When I update Amy's schedule with the following:
    | day    | time |
    | mon    | 1000 |
    | thu    | 1630 |
    | fri    | 1300 |
  And I am on "/schedules/overview"
  Then I should not see "No schedules have been added."
  And I should see the following times for "Amy":
    | day    | time |
    | tue    | 1000 |
    | wed    | 1000 |
    | thu    | 1000 |
    | thu    | 1630 |
    | fri    | 1300 |
    | fri    | 1600 |
  And I should see the following times for "Bette":
    | day    | time |
    | tue    | 1000 |
    | wed    | 1000 |
    | wed    | 1100 |
    | wed    | 1200 |
    | thu    | 1000 |