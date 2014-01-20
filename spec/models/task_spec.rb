require 'spec_helper'

describe Task do
  before { @task = FactoryGirl.create(:task) }

  subject { @task }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:work_id) }
  it { should respond_to(:images) }

  it { should be_valid }

  describe 'when title is not present' do
    before { @task.title = ' ' }
    it { should_not be_valid }
  end

  describe 'when description is not present' do
    before { @task.description = ' ' }
    it { should_not be_valid }
  end

  describe 'when work id is not present' do
    before { @task.work_id = nil }
    it { should_not be_valid }
  end
end
