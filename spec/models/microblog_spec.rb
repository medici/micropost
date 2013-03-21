require 'spec_helper'

describe Microblog do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @microblog = user.microblogs.build(content: "Lorem ipsum") }

  subject { @microblog }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
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
end
