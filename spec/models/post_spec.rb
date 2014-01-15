require 'spec_helper'

describe Post do
  before { @post = FactoryGirl.create(:post) }

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:content) }

  it { should be_valid }

  describe "there is no title field" do
    before { @post.title = " " }
    it { should_not be_valid }
  end

  describe "there is no content field" do
    before { @post.content = " " }
    it { should_not be_valid }
  end
end
