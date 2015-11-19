FactoryGirl.define do
  factory :convention do
    name "Test Convention"
    description "This is a test convention."
    initialize_with { Convention.where(name: name).first_or_create }
  end
end

