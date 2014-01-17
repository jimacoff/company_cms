require 'spec_helper'

describe Post do
  before { @post = FactoryGirl.create(:post) }

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:slug) }
  it { should respond_to(:friendly_id) }

  it { should be_valid }

  describe 'there is no title field' do
    before { @post.title = ' ' }
    it { should_not be_valid }
  end

  describe 'there is no content field' do
    before { @post.content = ' ' }
    it { should_not be_valid }
  end

  describe 'there is no slug field' do
    before { @post.slug = ' ' }
    it { should_not be_valid }
  end

  describe 'pretty url with friendly_id' do
    before do
      @post.title = 'Linh Vo Dich'
      @post.slug = nil
      @post.save!
    end

    its(:friendly_id) { should eq('linh-vo-dich') }
  end

  describe 'there should be no duplicate slug' do
    let(:post1) { FactoryGirl.create(:post) }
    before do
      @post.title = 'Linh Vo Dich'
      @post.slug = nil
      @post.save!
      post1.title = 'Linh Vo Dich'
      post1.slug = nil
      post1.save!
    end

    its(:friendly_id) { should_not eq(post1.friendly_id) }
  end
end
