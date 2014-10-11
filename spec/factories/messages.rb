# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user_id 1
    business_id 1
    subject "MyText"
    content "MyText"
    to_id 1
    to_entity "MyString"
    from_entity "MyString"
  end
end
