require 'spec_helper'

describe Admin::SessionsHelper do
  describe "Authenticate helper" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "user session after sign_in function" do
      specify { expect(session[:remember_token]).to eq user.id }
    end

    describe "user session after sign_out function" do
      before { sign_out }

      specify { expect(session[:remember_token]).to be_nil }
    end
  end
end
