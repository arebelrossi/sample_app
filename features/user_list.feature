Feature: User list
	In order to see a complete, paginated user list
	As a logged-in user

	Scenario: Show paginated user list
		Given I am logged in
		When I visit the user list page
		Then I should see a list of users
		And I should see the pagination links