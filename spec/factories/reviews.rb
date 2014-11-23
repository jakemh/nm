# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    reviewable_type "MyString"
    reviewable_id 1
    subject "MyText"
    body "MyText"
    score 1
  end
end
