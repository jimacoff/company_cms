namespace :db do
  desc "Fill database with service sample data"

  task populate_messages: :environment do

    10.times do
      message = Message.new
      message.email = Faker::Internet.email
      message.name = Faker::Name.name
      message.subject = Faker::Company.catch_phrase
      message.message = Faker::Lorem.paragraph
      message.save
    end
  end
end
