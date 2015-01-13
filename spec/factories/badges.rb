# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :badge do
    awardable_id 1
    awardable_type "MyString"
  end
end
