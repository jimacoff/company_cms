require 'spec_helper'

describe "Admin::UserPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "Edit Account" do
    before { visit account_path }

    it { should have_title(dashboard_title('Edit Account')) }
    it { should have_selector('h1', text: 'Edit Account') }

    describe "Change username with invalid information" do
      let(:new_username) { 'abc abc' }
      before do
        fill_in "Username", with: new_username
        fill_in "Old Password", with: user.password
        click_button 'Submit'
      end

      it { should have_selector('div.alert.alert-danger') }
    end

    describe "Change email with invalid information" do
      let(:new_email) { 'asdfb@   dadf@.com' }
      before do
        fill_in "Email", with: new_email
        fill_in "Old Password", with: user.password
        click_button 'Submit'
      end

      it { should have_selector('div.alert.alert-danger') }
    end

    describe "With invalid old password" do
      let(:new_username) { 'main_admin' }
      before do
        fill_in "Username", with: new_username
        fill_in "Old Password", with: 'asdf24234234'
        click_button 'Submit'
      end

      it { should have_selector('div.alert.alert-danger') }
    end

    describe "Change password" do
      let(:new_password) { '12345678' }

      describe "password and password confirmation match" do
        before do
          fill_in "New Password", with: new_password
          fill_in "New Password Confirmation", with: new_password
          fill_in "Old Password", with: user.password
          click_button 'Submit'
        end

        it { should have_selector('div.alert.alert-success') }
      end

      describe "password and password confirmation do not match" do
        before do
          fill_in "New Password", with: new_password
          fill_in "Old Password", with: user.password
          click_button 'Submit'
        end

        it { should have_selector('div.alert.alert-danger') }
      end
    end

    describe "Change username and email with valid information" do
      let(:new_username) { 'main_admin' }
      let(:new_email) { 'new@example.com' }
      before do
        fill_in "Username", with: new_username
        fill_in "Email", with: new_email
        fill_in "Old Password", with: user.password
        click_button 'Submit'
      end

      it { should have_selector('div.alert.alert-success') }
      it "have new username and email in the inputs" do
        expect(find_field('Username').value).to eq new_username
        expect(find_field('Email').value).to eq new_email
      end
    end

  end
end
