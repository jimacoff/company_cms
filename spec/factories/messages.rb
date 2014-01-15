# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    email "superclient@me.com"
    name "Aloha Alaxa"
    subject "Super Email"
    message "MyText aloha"
  end
end
