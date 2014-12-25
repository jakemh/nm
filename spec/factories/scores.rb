# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :score do
    score 1
    scoreable_type "MyString"
    storeable_id 1
    total_votes 1
  end
end
