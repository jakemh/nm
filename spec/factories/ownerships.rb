# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ownership do
    user_id 1
    business_id 1
    position "MyString"
  end
end
