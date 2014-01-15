require 'spec_helper'

describe Service do
  before { @service = FactoryGirl.create(:service) }

  subject { @service }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:image) }
  it { should respond_to(:image?) }
  it { should respond_to(:image_url) }
  it { should respond_to(:image_cache) }

  it { should be_valid }

  describe "when name is not present" do
    before { @service.name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @service.description = " " }
    it { should_not be_valid }
  end

  describe "when image is not present" do
    before { @service.image = " " }
    it { should_not be_valid }
  end

  describe "when a service name is duplicated" do
    let(:service_with_same_name) { @service.dup }
    before do
      service_with_same_name.save
    end

    subject { service_with_same_name }
    it { should_not be_valid }
  end
end
