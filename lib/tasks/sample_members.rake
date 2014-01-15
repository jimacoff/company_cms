namespace :db do
  desc "Fill database with service sample data"

  task populate_members: :environment do

    6.times do
      member = TeamMember.new
      member.title = Faker::Company.catch_phrase
      member.name = Faker::Name.name
      member.description = Faker::Lorem.sentence(5)
      member.avatar = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/placeholder.jpg'))
      member.save
    end
  end
end
