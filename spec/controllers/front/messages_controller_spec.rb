require 'spec_helper'

describe Front::MessagesController do

  describe "POST messages" do

    describe "create new message with ajax" do
      it "should respond with success" do
        expect do
          xhr :post, :create, message: { name: "test", email: "test@test.com", subject: "abc", message: "abcd ef ghik" }
        end.to change(Message, :count).by(1)
      end
    end
  end
end
