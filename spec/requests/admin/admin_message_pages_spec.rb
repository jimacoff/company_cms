require 'spec_helper'

describe "Admin::MessagePages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe 'List Messages' do
    before { visit messages_path }

    it { should have_title(dashboard_title('Message List')) }
    it { should have_selector('h1', 'Message List') }

    describe 'list of messages' do
      before(:all) { 30.times { FactoryGirl.create(:message) } }
      before(:all) { Message.delete_all }

      it "should have pagination and list messages" do
        Message.paginate(page: 1) do |message|
          expect(page).to have_selector 'ul.pagination'
          expect(page).to have_selector 'p', text: message.message
          expect(page).to have_selector 'p', text: message.email
          expect(page).to have_link(href: message_path(message))
        end
      end
    end

    describe 'delete message' do
      before do
        FactoryGirl.create(:message)
        visit messages_path
      end

      describe 'when click delete message link' do
        specify do
          expect do
            page.first('.message-delete').click()
          end.to change(Message, :count).by(-1)
        end
      end
    end
  end
end
