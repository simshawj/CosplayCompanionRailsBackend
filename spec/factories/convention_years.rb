FactoryGirl.define do
  factory :convention_year do
    date = Date.strptime("10-20-2015", "%m-%d-%Y")
    year 2015
    start date
    convention
    finish (date + 4.days)
  end

  factory :convention_year2, class: ConventionYear do
    date = Date.strptime("10-20-2016", "%m-%d-%Y")
    year 2016
    start date
    convention
    finish (date + 3.days)
  end
end
