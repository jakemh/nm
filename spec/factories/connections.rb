# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :connection do
    user_id 1
    friend_id 1
    business_id 1
    relationship "MyString"
  end
end
