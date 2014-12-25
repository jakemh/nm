# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point do
    score 1
    user_id 1
    business_id 1
    pointable_type "MyString"
    pointable_id 1
  end
end
