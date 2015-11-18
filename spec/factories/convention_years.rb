FactoryGirl.define do
  factory :convention_year do
    year 2015 
    start Date.today
    convention
    finish Date.today + 4.days
  end
end
