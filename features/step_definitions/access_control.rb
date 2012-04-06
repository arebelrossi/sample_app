Given /^I am logged in$/ do
  @user = FactoryGirl.create(:user)
  visit signin_path
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password 
  click_button "Sign in"
end

Given /^I am not the profile owner$/ do
end

When /^I visit the edit profile page of a different user$/ do
 @victim = User.create(name: "victim User", email: "victim@example.com",
                      password: "foobar", password_confirmation: "foobar")
	visit edit_user_path(@victim)
end

Then /^I should be redirected to the home page$/ do
  page.should have_content('Welcome to the Sample App')
end

Given /^I am not logged in$/ do
end

When /^I visit the user list page$/ do
	visit users_path
end

Then /^I should be redirected to the sign in page$/ do
	page.should have_button('Sign in')
end

Then /^I should see an error message$/ do
  page.should have_content('Please sign in')
end
