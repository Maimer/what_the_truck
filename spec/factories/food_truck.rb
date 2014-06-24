FactoryGirl.define do
  factory :food_truck do
    sequence(:name) { |n| "Test Name #{n}"}
    description "Super awesome generic description"
  end
end
