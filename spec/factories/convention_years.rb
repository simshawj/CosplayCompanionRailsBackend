FactoryGirl.define do
  factory :convention_year do
    date = Date.strptime("10-20-2015", "%m-%d-%Y")
    year 2015
    start date
    finish (date + 4.days)
    convention { Convention.first || FactoryGirl.create(:convention) }
  end

  factory :convention_year2, class: ConventionYear do
    date = Date.strptime("10-20-2016", "%m-%d-%Y")
    year 2016
    start date
    finish (date + 3.days)
    convention { Convention.first || FactoryGirl.create(:convention) }
  end
end
