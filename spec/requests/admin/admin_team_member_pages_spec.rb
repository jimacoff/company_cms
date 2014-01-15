require 'spec_helper'

describe "Admin::TeamMemberPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "List TeamMember" do
    before { visit team_members_path }

    it { should have_title(dashboard_title('Team List')) }
    it { should have_selector('h1', text: 'Team List') }
    it { should have_link('Add New Member', href: new_team_member_path) }

    describe 'list of team members' do
      before(:all) { 30.times { FactoryGirl.create(:team_member) } }
      before(:all) { TeamMember.delete_all }

      it "should have pagination and list each service" do
        TeamMember.paginate(page: 1) do |member|
          expect(page).to have_selector 'ul.pagination'
          expect(page).to have_selector 'p', text: member.description
          expect(page).to have_link(href: edit_team_member_path(member))
          expect(page).to have_link(href: team_member_path(member))
        end
      end
    end

    describe 'delete team member' do

      before do
        1.times { FactoryGirl.create(:team_member) }
        visit team_members_path
      end

      describe 'when click delete service link' do
        specify do
          expect do
            page.first('.member-delete').click()
          end.to change(TeamMember, :count).by(-1)
        end
      end

    end

    describe 'edit memeber' do
      before do
        1.times { FactoryGirl.create(:team_member) }
        visit team_members_path
      end

      describe 'when click edit member link' do
        before { page.first('.member-edit').click() }

        it { should have_title(dashboard_title('Edit Member')) }
        it { should have_selector('h1', text: 'Edit Member') }

        describe "with invalid information" do
          let(:new_name) { "" }

          before do
            fill_in "Name", with: new_name
            click_button "Submit"
          end

          it { should have_selector('span.error-help') }
        end

        describe "with valid information" do
          let(:new_name) { "Superman" }

          before do
            fill_in "Name", with: new_name
            click_button "Submit"
          end

          it { should have_selector('div.alert.alert-success') }
          it "should have new name displayed" do
            find_field('Name').value.should eq new_name
          end
        end
      end
    end

    describe 'add new team member page' do
      before { visit new_team_member_path }

      it { should have_title(dashboard_title('Add New Member')) }
      it { should have_selector('h1', text: 'Add New Member') }

      let(:submit) { 'Submit' }

      describe "add new member" do
        describe "with invalid information" do
          it "should not create a new member" do
            expect { click_button submit }.not_to change(TeamMember, :count)
          end
        end

        describe "upload image with invalid file type" do
          before do
            fill_in "Title", with: "Super developer"
            fill_in "Name", with: "Handsome guy"
            fill_in "Description", with: "lazy guy"
            attach_file 'team_member_avatar', "#{Rails.root}/spec/fixtures/files/playbook.epub"
          end

          it "should not create a new member" do
            expect { click_button submit }.not_to change(TeamMember, :count)
          end
        end

        describe "upload image with invalid file size" do
          before do
            fill_in "Title", with: "Super developer"
            fill_in "Name", with: "Handsome guy"
            fill_in "Description", with: "lazy guy"
            attach_file 'team_member_avatar', "#{Rails.root}/spec/fixtures/files/test.jpg"
          end

          it "should not create a new member" do
            expect { click_button submit }.not_to change(TeamMember, :count)
          end
        end

        describe "with valid information" do
          before do
            fill_in "Title", with: "Super developer"
            fill_in "Name", with: "Handsome guy"
            fill_in "Description", with: "lazy guy"
            attach_file 'team_member_avatar', "#{Rails.root}/spec/fixtures/files/placeholder.jpg"
          end

          it "should not create a new member" do
            expect { click_button submit }.to change(TeamMember, :count).by(1)
          end
        end
      end

    end
  end
end
