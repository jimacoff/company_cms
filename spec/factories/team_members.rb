# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_member do
    sequence(:title) { |n| "Dragon #{n}" }
    sequence(:name) { |n| "Super Dragon #{n}" }
    sequence(:description) { |n|"Dragon King #{n}" }
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/placeholder.jpg')) }
  end
end
