require 'spec_helper'

describe Microblog do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @microblog = user.microblogs.build(content: "Lorem ipsum") }

  subject { @microblog }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:in_reply_to) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @microblog.user_id = nil }
  	it { should_not be_valid }
  end

  describe "with blank content" do
    before { @microblog.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @microblog.content = "a" * 141 }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Microblog.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "replied associations" do
    before { @microblog.save }
    let!(:replied_user) { FactoryGirl.create(:user) }
    let!(:replying_microblog) { FactoryGirl.create(:microblog, user: replied_user, 
                               in_reply_to: @microblog.id) }
    let!(:in_reply_to) { Microblog.including_replies(@microblog.id) }

    subject { in_reply_to }


    it { should == [replying_microblog] }
  end

  
end
