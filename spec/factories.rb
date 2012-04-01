FactoryGirl.define do
	factory :user do
		name	"Dario Pedicini"
		email	"dario@email.com"
		password "foobar"
		password_confirmation "foobar"
	end
end