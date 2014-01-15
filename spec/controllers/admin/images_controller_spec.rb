require 'spec_helper'

describe Admin::ImagesController do

  let(:user) { FactoryGirl.create(:user) }
  let(:work) { FactoryGirl.create(:work) }


  describe "DELETE images/:id" do
    let(:image) { FactoryGirl.create(:image, imageable: work) }
    before do
      work.save
      image.save
    end

    describe "authorized user" do
      before { sign_in user, no_capybara: true }
      it { expect { delete :destroy, id: image }.to change(Image, :count).by(-1) }

      it "should redirect after delete" do
        delete :destroy, id: image
        response.should redirect_to(work_path(work))
      end
    end

    describe "unauthorized user" do
      it { expect { delete :destroy, id: image  }.not_to change(Image, :count) }
    end

  end
end
