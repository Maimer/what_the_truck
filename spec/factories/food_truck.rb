FactoryGirl.define do
  factory :food_truck do
    sequence(:name) { |n| "Test Name #{n}"}
    description "Super awesome generic description"
    user_id 1 #hard coded user id to match id in spec/models/review_spec.rb
  end
end
