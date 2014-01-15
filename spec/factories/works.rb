# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :work do
    sequence(:name) { |n| "Super Website #{n}"}
    sequence(:client) { |n| "Apple #{n}" }
    sequence(:story) { |n| "10 days of sleepness #{n}" }
    sequence(:techs) { |n| "Rails, NodeJS, AngularJS #{n}" }
  end
end
