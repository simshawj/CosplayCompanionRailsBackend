FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "johndoe#{n}" }
    sequence(:email) { |n| "john.doe#{n}@someplace.com" }
    password "Insecure"
  end
end
