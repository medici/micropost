require 'spec_helper'

describe "Microblog Pages" do
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


	describe "replied/repyling" do
		let!(:replied_user) { FactoryGirl.create(:user) }
		let!(:replied_microblog) do
			FactoryGirl.create(:microblog, content:'microblog be replied',
				                  user: replied_user)
		end
		let!(:replying_microblog) do
			FactoryGirl.create(:microblog, user: user, content: 'replying microblog',
			                    in_reply_to: replied_microblog.id)
		end
    describe "replied" do
    	before do
    		sign_in replied_user
    		visit root_path
    	end

    	it { should have_link('Expand',
    	     href: expand_microblog_path(replied_microblog.id) ) }

    	describe "should not be nil" do
    		subject { replying_microblog.in_reply_to }

    		it { should_not be_nil }
    	end

    	it "click Expand / Collapse", :js => true do
    		page.should_not have_selector('span', text: 'replying microblog')
	      click_link "Expand"
	      page.should_not have_link('Expand')
	      page.should have_link('Collapse')
	      page.should have_selector('span',text: 'replying microblog')

	      click_link "Collapse"
	      page.should have_link('Expand')
	      page.should_not have_link('Collapse')
	    end

    end

		describe "replying" do
			before do
    		sign_in user
    		visit root_path
    	end
			
			it { should have_link('View',
				   href: view_conversation_microblog_path(replying_microblog.id) ) }

			it "click View conversation", :js => true do
				page.should_not have_selector('span', text: 'microblog be replied')
				click_link "View conversation"
				page.should_not have_link('View conversation')
				page.should have_link('Hide conversation')
				page.should have_selector('span', text: 'microblog be replied')

				click_link "Hide conversation"
				page.should_not have_link('Hide conversation')
				page.should have_link('View conversation')
			end
		end

		describe "create replying micropost" do
			before do
				visit root_path
				click_link 'Reply'
			  fill_in "reply_form_#{replying_microblog.id}", with: "first replying micropost" 
			  click_button 'Reply'
			end
			it { should have_content('first replying micropost')}
		end

	end             
end
