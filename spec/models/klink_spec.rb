require 'spec_helper'

describe Klink do
  let(:user) { FactoryGirl.create(:user) }
  before { @klink = user.klinks.build(description: "klink description") }

  subject { @klink }

  it { should respond_to(:description) }
  it { should respond_to(:user_id) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @klink.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Klink.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @klink.user_id = nil }
    it { should_not be_valid }
  end
end