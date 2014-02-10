# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :work do
    sequence(:name) { |n| "Super Website #{n}" }
    sequence(:client_name) { |n| "Apple #{n}" }
    sequence(:story) { |n| "10 days of sleepness #{n}" }
    sequence(:techs) { |n| "Rails, NodeJS, AngularJS #{n}" }
    sequence(:link) { |n| "http://myproduct#{n}.com" }
    cover_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/placeholder.jpg')) }
    association :category, factory: :work_category
    client_info 'Test'
    client_quote 'Test'
  end
end
