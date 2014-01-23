namespace :mail do
  desc "Send test contact mail"

  task contact: :environment do
    message = Message.create!(email: Faker::Internet.email,
                             name: Faker::Name.name,
                             subject: Faker::Company.catch_phrase,
                             message: Faker::Lorem.paragraph
                            )

    MessageMailer.contact_email(message).deliver
  end
end
