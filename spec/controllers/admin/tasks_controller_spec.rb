require 'spec_helper'

describe Admin::TasksController do

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user, no_capybara: true }

  describe 'POST works/:work_id/tasks' do
    let(:work) { FactoryGirl.create(:work) }
    describe 'create a new task with no image' do
      before do
        post :create, work_id: work.id, task: { title: 'abc', description: 'abc' }
      end

      it { expect(response.status).to eql(302) }
      specify { response.should redirect_to work_url(work) }
    end

    describe 'create a new task with image' do
      before do
        request.accept = 'application/json'
        post :create, work_id: work.id, task: { title: 'abc', description: 'abc' }, file: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/test.jpg'), 'image/jpeg'), Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/test.jpg'), 'image/jpeg')]
        @response_body = JSON.parse(response.body)
      end

      it { expect(response.status).to eql(200) }
      it { expect(@response_body['status']).to eql(1) }
    end

  end

  describe 'PATCH tasks/:id' do
    let(:task) { FactoryGirl.create(:task) }
    let(:new_title) { 'abc' }
    describe 'edit a task with out adding image' do
      before do
        patch :update, id: task.id, task: { title: new_title, description: 'abc' }
      end

      it { expect(response.status).to eql(302) }
      specify { response.should redirect_to edit_task_url(task) }
      specify { expect(task.reload.title).to eql(new_title)  }
    end

    describe 'update a new task with new image' do
      before do
        request.accept = 'application/json'
        patch :update, id: task.id, task: { title: new_title, description: 'abc' }, file: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/test.jpg'), 'image/jpeg'), Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/test.jpg'), 'image/jpeg')]
        @response_body = JSON.parse(response.body)
      end

      it { expect(response.status).to eql(200) }
      it { expect(@response_body['status']).to eql(1) }
      specify { expect(task.reload.title).to eql(new_title)  }
    end
  end
end
