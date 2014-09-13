# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    name "MyString"
    taggable_id 1
    taggable_type "MyString"
  end
end
