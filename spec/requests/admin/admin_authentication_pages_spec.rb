require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "Login Page" do
    before { visit login_path }

    it { should have_title(dashboard_title('Log In')) }
    it { should have_selector('h1', text: 'Log In') }
  end

  describe "Sign In" do

    describe "with invalid information" do
      before do
        visit login_path
        click_button "Log In"
      end

      it { should have_title(dashboard_title('Log In')) }
      it { should have_selector('div.alert.alert-danger') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_link('Boss Dashboard', href: boss_path) }
      it { should have_link('logout', href: logout_path) }

      describe "followed by signout" do
        before { click_link "logout" }
        it { should have_selector('h1', text: 'Log In') }
      end
    end
  end

  describe "Authorization" do
    describe "for not logged-in user" do

      describe "in the Admin namespace route" do

        describe "visit admin main page" do
          before { visit boss_path}
          it { should have_title('Log In') }
          it { should have_selector('h1', text: 'Log In') }
        end
      end
    end
  end
end
