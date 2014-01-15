require 'spec_helper'

describe Message do

  before { @message = FactoryGirl.create(:message) }

  subject { @message }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:subject) }
  it { should respond_to(:message) }

  it { should be_valid }

  describe "there is no email field" do
    before { @message.email = " " }
    it { should_not be_valid }
  end

  describe "invalid email address" do
    before { @message.email = "adbadf@asdf" }
    it { should_not be_valid }
  end

  describe "there is no message field" do
    before { @message.message = " " }
    it { should_not be_valid }
  end
end
