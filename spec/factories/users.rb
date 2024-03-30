FactoryBot.define do
  sequence(:email) { |n| "user#{n}@example.com" }
  sequence(:username) { |n| "username#{n}" }
  factory :user do
    username
    email
    password { 'Password11$$' }
    password_confirmation { 'Password11$$' }
    trait :confirmed do
      confirmed_at { DateTime.now }
    end
  end
end
