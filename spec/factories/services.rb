# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    sequence(:name) { |n| "Super Dragon Service #{n}" }
    sequence(:description) { |n| "Service for all of you #{n}" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/placeholder.jpg')) }
  end
end
