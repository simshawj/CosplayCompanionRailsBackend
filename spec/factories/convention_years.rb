FactoryGirl.define do
  factory :convention_year do
    year 2015 
    days 4
    start Date.today
    association :convention, factory: :convention, strategy: :build
    
  end

end
