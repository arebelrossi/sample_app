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
  fill_in "Name",         with: "Example user"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",     with: "foobar"
  fill_in "Confirmation", with: "foobar"
end