# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message_recipient do
    message_id 1
    user_id 1
    business_id 1
  end
end
