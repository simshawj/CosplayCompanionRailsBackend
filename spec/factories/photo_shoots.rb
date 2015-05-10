FactoryGirl.define do
  factory :photo_shoot do
    series "A Test Series"
    start DateTime.now.noon
    location "End of Time"
    association :convention_year, factory: :convention_year, strategy: :create
    
  end

end

