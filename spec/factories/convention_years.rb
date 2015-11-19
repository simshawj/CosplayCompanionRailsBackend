FactoryGirl.define do
  factory :convention_year do
    date = Date.strptime("10-20-2015", "%m-%d-%Y")
    year 2015
    start date
    location "The Moon"
    finish (date + 4.days)
    convention { Convention.first || FactoryGirl.create(:convention) }
  end

  factory :convention_year2, class: ConventionYear do
    date = Date.strptime("10-20-2016", "%m-%d-%Y")
    year 2016
    start date
    location "Mars"
    finish (date + 3.days)
    convention { Convention.first || FactoryGirl.create(:convention) }
  end
end
