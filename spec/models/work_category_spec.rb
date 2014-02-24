require 'spec_helper'

describe WorkCategory do
  before { @category = FactoryGirl.create(:work_category) }

  subject { @category }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:works) }

  it { should be_valid }

  describe 'when name is not present' do
    before { @category.name = ' ' }
    it { should_not be_valid }
  end

  describe 'should be able to create a new work for this category' do
    let(:work) { FactoryGirl.create(:work) }
    before do
      work.category_id = @category.id
      work.save!
    end

    its(:works) { should include(work) }
  end
end
