# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message_poly do
    user_id 1
    business_id 1
    subject "MyText"
    content "MyText"
    messageable_id 1
    messageable_type "MyString"
  end
end
