# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    imageable_id 1
    imageable_type "MyString"
  end
end
