FactoryGirl.define do
  factory :review do
    rating "5"
    body "A review of our Test Name truck"
    user_id ""
    food_truck
  end
end
