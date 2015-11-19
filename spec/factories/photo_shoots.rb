FactoryGirl.define do
  factory :photo_shoot do
    series "A Test Series"
    start DateTime.strptime("10-22-2015 12:00pm", "%m-%d-%Y %I:%M%p")
    location "End of Time"
    convention_year
  end
end

