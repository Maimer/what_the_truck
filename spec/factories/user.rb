FactoryGirl.define do
  factory :user do
    first_name "Charles"
    last_name "Xavier"
    sequence(:email) { |n| "#{first_name}#{n}#{last_name}@example.com"}
    password "password"
    password_confirmation "password"
  end
end
