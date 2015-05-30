FactoryGirl.define do
  factory :photo_shoot do
    series "A Test Series"
    start DateTime.now.noon
    location "End of Time"
    convention_year
    
  end

end

