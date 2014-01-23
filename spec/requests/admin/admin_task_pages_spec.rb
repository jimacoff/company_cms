require 'spec_helper'

describe 'Admin::TaskPages' do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  let(:task) { FactoryGirl.create(:task) }
before do
  3.times { task.images.create!(file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/placeholder.jpg'))) }
  end

  describe 'Show task page' do
    before { visit task_path(task) }

    it { should have_content(task.title) }
    it { should have_content(task.description) }

    describe 'image list' do
      it 'should have a list of task\'s images' do
        expect(page.all('.task-image').count).to eq task.images.count
      end
    end
  end

  describe 'Edit task page' do
    before { visit edit_task_path(task) }

    it { should have_title(dashboard_title('Edit Task')) }
    it { should have_selector('h1', 'Edit Task') }
  end

end
