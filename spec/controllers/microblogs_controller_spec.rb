require 'spec_helper'

describe MicroblogsController do
	let(:user) { FactoryGirl.create(:user) }
	let(:other_user) { FactoryGirl.create(:user) }
	let!(:m1) do
		user.microblogs.build(content: "the microblogs be replied")
	end
	let!(:m2) do
		FactoryGirl.create(:microblog, user: other_user, in_reply_to: m1.id)
	end
	let!(:m3) do
		FactoryGirl.create(:microblog, user: user,in_reply_to: m2.id)
	end

	before do
		m1.save
		m2.save
		m3.save
		sign_in user
	end

	describe "should be replied" do
		it "should respond with success" do
			xhr :get, :expand, id: m1.id
			response.should be_success
		end
	end

	describe "should replying to" do
		it "should respond with success" do
			xhr :get, :view_conversation, id: m3.id
			 response.should be_success
		end
	end
end