require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_title('The Company') }
    it { should have_selector('h1', text: 'The Company') }

    describe "sending a message through contact form" do
      describe "with valid information" do
        before do
          fill_in "Email", with: "abc@abc.com.vn"
          fill_in "Message", with: "Holla Hop"
        end

        it "should create a new mesage" do
          expect { click_button 'Submit' }.to change(Message, :count).by(1)
        end
      end

    end
  end
end
