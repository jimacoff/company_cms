require 'spec_helper'

describe 'Admin::TaskPages' do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "Show task page" do
    let(:task) { FactoryGirl.create(:task) }
    before do
      visit task_path(task)
    end

    it { should have_content(task.title) }
    it { should have_content(task.description) }
  end
end
