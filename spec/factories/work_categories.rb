# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :work_category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:description) { |n| "MyText #{n}" }
  end
end
