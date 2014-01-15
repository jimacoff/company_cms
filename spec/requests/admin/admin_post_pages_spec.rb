require 'spec_helper'

describe "Admin::PostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "Blog List Pages" do
    before { visit posts_path }

    it { should have_title(dashboard_title('Blog')) }
    it { should have_selector('h1', text: 'Blog') }
    it { should have_link('Add New Post', href: new_post_path ) }

    describe 'list of services' do
      before(:all) { 30.times { FactoryGirl.create(:post) } }
      before(:all) { Post.delete_all }

      it "should have pagination and list each service" do
        Post.paginate(page: 1) do |post|
          expect(page).to have_selector 'ul.pagination'
          expect(page).to have_selector 'p', text: post.description
          expect(page).to have_link(href: edit_post_path(post))
          expect(page).to have_link(href: post_path(post))
        end
      end

    end

    describe "Add new post page" do
      before { click_link 'Add New Post' }

      it { should have_title(dashboard_title('Add New Post')) }
      it { should have_selector('h1', text: 'Add New Post') }

      describe "Create new post" do
        describe "with valid information" do
          before do
            fill_in "Title", with: "Super Post"
            fill_in "Content", with: "Aloha aloba"
          end

          it "should create a new post" do
            expect { click_button 'Submit' }.to change(Post, :count).by(1)
          end
        end

        describe "with invalid information" do
          before do
            fill_in "Title", with: " "
            fill_in "Content", with: "Aloha aloba"
          end

          it "should create a new post" do
            expect { click_button 'Submit' }.not_to change(Post, :count)
          end
        end

        describe "with invalid information" do
          before do
            fill_in "Title", with: "ABC"
            fill_in "Content", with: " "
          end

          it "should create a new post" do
            expect { click_button 'Submit' }.not_to change(Post, :count)
          end
        end
      end
    end

  end

  describe 'Delete posts' do
    before do
      1.times { FactoryGirl.create(:post) }
      visit posts_path
    end

    specify do
      expect do
        page.first('.post-delete').click()
      end.to change(Post, :count).by(-1)
    end
  end

  describe "Post Info Page" do
    let(:post) { FactoryGirl.create(:post) }

    before { visit post_path(post) }

    it { should have_content(post.title) }

  end

  describe 'Edit post page' do
    let(:post) { FactoryGirl.create(:post) }

    before { visit edit_post_path(post) }

    it { should have_title(dashboard_title('Edit Post')) }
    it { should have_selector('h1', text: 'Edit Post') }

    describe 'with valid information' do
      let(:new_title) { '123456' }

      before do
        fill_in 'Title', with: new_title
        click_button 'Submit'
      end

      it { should have_selector('div.alert.alert-success') }
      it "should have new title displayed" do
        find_field('Title').value.should eq new_title
      end
    end
  end
end
