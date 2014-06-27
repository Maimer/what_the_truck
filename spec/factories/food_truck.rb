FactoryGirl.define do
  factory :food_truck do
    sequence(:name) { |n| "Truck #{n}"}
    description "Super awesome generic description"
    user
  end
end
