namespace :db do
  desc "Fill database with service sample data"

  task populate_services: :environment do

    6.times do
      service = Service.new
      service.name = Faker::Name.name
      service.description = Faker::Lorem.sentence(5)
      service.image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/placeholder.jpg'))
      service.save
    end
  end
end
