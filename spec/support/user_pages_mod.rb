RSpec::Matchers.define :have_all_error_messages do
 	match do |page|
   	page.should have_css('div#error_explanation')
   	page.should have_content("The form contains 6 errors")
 	end
end

def click_user_create_button
	click_button "Create my account"
end

def valid_signup
  fill_in "Name",         		with: "Example user"
  fill_in "Email",        		with: "user@example.com"
  fill_in "Password",     		with: "foobar"
  fill_in "Confirm Password", with: "foobar"
end

def valid_user_update
	fill_in "Name",             with: new_name
	fill_in "Email",            with: new_email
	fill_in "Password",         with: user.password
	fill_in "Confirm Password", with: user.password
	click_button "Save changes"
end