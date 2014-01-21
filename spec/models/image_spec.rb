require 'spec_helper'

describe Image do
  let(:task) { FactoryGirl.create(:task) }
  before do
    @image = task.images.build(
      file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/placeholder.jpg'))
    )
  end

  subject { @image }

  it { should respond_to(:file) }
  it { should respond_to(:imageable_id) }
  it { should respond_to(:imageable_type) }
  it { should respond_to(:imageable) }

  it { should be_valid }

  describe "when file is not present" do
    before { @image.file = " " }
    it { should_not be_valid }
  end
end
