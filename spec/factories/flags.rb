# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flag do
    flaggable_type "MyString"
    flaggable_id 1
    user_id 1
    description "MyText"
    category 1
  end
end
