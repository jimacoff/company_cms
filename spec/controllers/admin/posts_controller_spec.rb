require 'spec_helper'

describe Admin::PostsController do

  let(:user) { FactoryGirl.create(:user) }


  describe 'POST posts/uploadImage' do

    describe 'authorized user' do
      before { sign_in user, no_capybara: true }

      describe 'upload a valid image' do
        before do
          request.accept = 'application/json'
          post :upload_image, file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/placeholder.jpg'), 'image/jpeg')
          @response_body = JSON.parse(response.body)
        end

        it { expect(response.status).to eql(200) }
        it { expect(@response_body['status']).to eql(1) }
      end

      describe 'upload an oversized image' do

        before do
          request.accept = 'application/json'
          post :upload_image, file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/test.jpg'), 'image/jpeg')
          @response_body = JSON.parse(response.body)
        end

        it { expect(response.status).to eql(200) }
        it { expect(@response_body['status']).to eql(0) }
      end

      describe 'upload an invalid image' do

        before do
          request.accept = 'application/json'
          post :upload_image, file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/playbook.epub'), 'application/epub')
          @response_body = JSON.parse(response.body)
        end

        it { expect(response.status).to eql(200) }
        it { expect(@response_body['status']).to eql(0) }
      end
    end

    describe 'unauthorized user' do
      before do
        post :upload_image, file: ' '
      end

      it { expect(response.should redirect_to(login_path)) }
    end

  end
end
