require 'spec_helper'

describe TeamMember do
  before { @member = FactoryGirl.create(:team_member) }

  subject { @member }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:title) }
  it { should respond_to(:avatar) }
  it { should respond_to(:avatar_url) }
  it { should respond_to(:avatar_cache) }

  it { should be_valid }

  describe "when title is no present" do
    before { @member.title = " " }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @member.name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @member.description = " " }
    it { should_not be_valid }
  end

  describe "when image is not present" do
    before { @member.avatar = " " }
    it { should_not be_valid }
  end

end
