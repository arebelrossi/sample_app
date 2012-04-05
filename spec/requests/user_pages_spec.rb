require 'spec_helper'
require 'support/user_pages_mod'

describe "User pages" do
  subject { page }

  describe "signup page" do
  	before { visit signup_path }
  	
  	it { should be_entitled 'Sign up' }
  	
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_user_create_button }.not_to change(User, :count)
      end
      describe "error messages" do
        before { click_user_create_button }
        
        it { should be_entitled "Sign up" }
        it { should have_all_error_messages }
      end
    end

    describe "with valid information" do
      before { valid_signup }

      it "should create a user" do
        expect do
          click_user_create_button 
        end.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_user_create_button }
        let(:user) { example_user }

        it { should be_entitled user.name }
        it { should have_welcome_message('Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end
  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should be_entitled user.name }
  end
end
