Feature: access control
	So that I can't access sensitive contents
	As a malicious user
 	I want to be unable to see or edit the contents of sensitive pages

	Scenario: Edit other user profile
	Given I am logged in
	And I am not the profile owner
	When I visit the edit profile page of a different user
	Then I should be redirected to the home page

	Scenario: See user list
	Given I am not logged in
	When I visit the user list page
	Then I should be redirected to the sign in page
	And I should see an error message

