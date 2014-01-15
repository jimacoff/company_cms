require 'spec_helper'

describe "Admin::ServicePages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe 'List Services' do
    before { visit boss_path }

    it { should have_title(dashboard_title('Service List')) }
    it { should have_selector('h1', text: 'Service List') }
    it { should have_link('Add New Service', href: new_service_path) }

    describe 'list of services' do
      before(:all) { 30.times { FactoryGirl.create(:service) } }
      before(:all) { Service.delete_all }

      it "should have pagination and list each service" do
        Service.paginate(page: 1) do |service|
          expect(page).to have_selector 'ul.pagination'
          expect(page).to have_selector 'p', text: service.description
          expect(page).to have_link(href: edit_service_path(service))
          expect(page).to have_link(href: service_path(service))
        end
      end

    end

    describe 'delete services' do

      before do
        1.times { FactoryGirl.create(:service) }
        visit services_path
      end

      describe 'when click delete service link' do
        specify do
          expect do
            page.first('.service-delete').click()
          end.to change(Service, :count).by(-1)
        end
      end

    end

    describe 'edit service' do
      before do
        1.times { FactoryGirl.create(:service) }
        visit services_path
      end

      describe 'when click edit service link' do
        before { page.first('.service-edit').click() }

        it { should have_title(dashboard_title('Edit Service')) }
        it { should have_selector('h1', text: 'Edit Service') }

        describe "with invalid information" do
          let(:new_name) { "" }

          before do
            fill_in "service_name", with: new_name
            click_button "Submit"
          end

          it { should have_selector('span.error-help') }
        end

        describe "with valid information" do
          let(:new_name) { "Superman" }

          before do
            fill_in "service_name", with: new_name
            click_button "Submit"
          end

          it { should have_selector('div.alert.alert-success') }
          it "should have new name displayed" do
            find_field('Name').value.should eq new_name
          end
        end
      end
    end

  end

  describe 'new service' do
    before { visit new_service_path }

    it { should have_title(dashboard_title('Add New Service')) }
    it { should have_selector('h1', text: 'Add New Service') }

    let(:submit) { 'Submit' }

    describe "add new sevice" do
      describe "with invalid information" do
        it "shoud not create a new service" do
          expect { click_button submit }.not_to change(Service, :count)
        end
      end

      describe "upload image with invalid file type" do
        before do
          fill_in "Name", with: "Super Service"
          fill_in "Description", with: "Holla Hopp"
          attach_file 'service_image', "#{Rails.root}/spec/fixtures/files/playbook.epub"
        end

        it "shoud not create a new service" do
          expect { click_button submit }.not_to change(Service, :count)
        end
      end

      describe "upload image with invalid file size" do
        before do
          fill_in "Name", with: "Super Service"
          fill_in "Description", with: "Holla Hopp"
          attach_file 'service_image', "#{Rails.root}/spec/fixtures/files/test.jpg"
        end

        it "shoud not create a new service" do
          expect { click_button submit }.not_to change(Service, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name", with: "Super Service"
          fill_in "Description", with: "Holla Hopp"
          attach_file 'service_image', "#{Rails.root}/spec/fixtures/files/placeholder.jpg"
        end

        it "should create a new service" do
          expect { click_button submit }.to change(Service, :count).by(1)
        end
      end
    end
  end

end
