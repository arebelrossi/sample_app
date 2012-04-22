require 'spec_helper'
require 'support/user_pages_mod'

describe "User pages" do
  subject { page }

  describe "index" do    
    let(:user) { FactoryGirl.create(:user) }
    before do
      valid_signin user
      visit users_path
    end

    it { should have_selector('title', text:'All users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_link('Next') }
      its(:html) { should match('>2</a>') }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          valid_signin admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end

  end

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
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }
    let(:other_user) { FactoryGirl.create(:user) }
      
  	before { visit user_path(user) }

  	it { should be_entitled user.name }
    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end

    describe "should not allow incorrect user to delete microposts" do
      before do
        valid_signin user
        FactoryGirl.create(:micropost, user: other_user, content: "Bar")
        visit user_path(other_user)
      end

      it { should_not have_selector('a', text:"delete") }
    end

    describe "pagination" do
      before do
        40.times { FactoryGirl.create(:micropost, user: user, content: "foobar") } 
        visit user_path(user)
      end
      after { user.microposts.delete_all }
      
      it { should have_link('Next') }
      its(:html) { should match('>2</a>') }
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      valid_signin user
     visit edit_user_path(user)
   end 

    describe "page" do
      it { should have_selector('h1',     text: 'Update your profile') }
      it { should have_selector('title',   text:'Edit user') }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content("error") }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before { valid_user_update }

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', :href => signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end 
  end
end
