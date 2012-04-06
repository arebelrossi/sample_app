Then /^I should see a list of users$/ do
	40.times { FactoryGirl.create(:user) }
	visit current_path
	User.all[0..2].each do |user|
		page.should have_selector('li', text: user.name)
	end
end

Then /^I should see the pagination links$/ do
	page.should have_link('Next')
	page.html.should match('>2</a>')
end
