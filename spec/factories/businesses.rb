# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :business do
    name "MyString"
    website "MyString"
    address "MyString"
    city "MyString"
    state "MyString"
    zip 1
    business_type "MyString"
    industry "MyString"
    description "MyText"
  end
end
