require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { valid_signin user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.should_not change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do
      before { fill_in 'micropost_content', with: "Lorem ipsum" }

      it "should create a micropost" do
        expect { click_button "Post" }.should change(Micropost, :count).by(1)
      end
    end

#    describe "splits very long words" do
#      pending( "-- match() fails --")
#       before do 
#         fill_in 'micropost_content', with: ("a"* 31)
#         click_button "Post"
#       end
#       its(:body) { should match('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&#8203;a') }
#    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.should change(Micropost, :count).by(-1)
      end
    end
  end
end