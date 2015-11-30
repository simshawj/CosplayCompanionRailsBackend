FactoryGirl.define do
  factory :user do
    username "johndoe"
    email "john.doe@someplace.com"
    password "Insecure"
    password_confirmation "Insecure"
    confirmed_at Time.now
  end
end
