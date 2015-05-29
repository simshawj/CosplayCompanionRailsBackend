require 'rails_helper'

describe "Convention_Year list" do
  it "lists conventions with a year" do
    con1 = create(:convention, name: "convention 1")
    con2 = create(:convention, name: "convention 2")

    con1year1 = create(:convention_year, year: 2012, convention: con1)
    con1year2 = create(:convention_year, year: 2013, convention: con1)
    con1year3 = create(:convention_year, year: 2014, convention: con1)
    con2year1 = create(:convention_year, year: 2012, convention: con2)
    con2year2 = create(:convention_year, year: 2015, convention: con2)

    visit(convention_years_path)
    
    expect(page).to have_content con1.name
    expect(page).to have_content con2.name
    expect(page).to have_content con1year1.year
    expect(page).to have_content con1year2.year
    expect(page).to have_content con1year3.year
    expect(page).to have_content con2year1.year
    expect(page).to have_content con2year2.year
  end
end
