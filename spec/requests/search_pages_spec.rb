require 'spec_helper'

describe "Search Pages" do
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let!(:other_user) { FactoryGirl.create(:user, name: 'search people') }
	before do
		sign_in user 
	end

	describe "search" do
		describe "has corresponding people" do
			before do
				fill_in "searchs_name", with: "search people"
				click_button "Search"
			end
			it { should have_selector('a', text: 'search people')}
		end

		describe "has no searched people" do
			before do
				fill_in "searchs_name", with: "searched peoples"
				click_button "Search"
			end
			it { should have_selector('p', text: 'no result')}
		end
	end
end
