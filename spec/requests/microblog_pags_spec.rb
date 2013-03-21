require 'spec_helper'

describe "Microblog Pags" do
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "microblog creation" do
		before { visit root_path }

		describe "with invalid information" do

			it "should not create a microblog" do
				expect { click_button "Post" }.not_to change(Microblog, :count)
			end

			describe "error messages" do
				before { click_button "Post" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do

			before { fill_in 'microblog_content', with: "Lorem ipsum" }
			it "should create a microblog" do
				expect { click_button "Post" }.to change(Microblog, :count).by(1)
			end
		end
	end

	describe "microblog destruction" do
		before { FactoryGirl.create(:microblog, user: user) }

		describe "as correct user" do
			before { visit root_path }

			it "should delete a microblog" do
				expect { click_link "delete" }.to change(Microblog, :count).by(-1)
			end
		end
	end
end
