require 'rails_helper'

describe "Show Convention" do
  it "displays the information about the convention including years" do
    con = create(:convention)
    con2 = create(:convention, name: "Convention 2")

    con_year = create(:convention_year, year: 2012, convention: con)
    con2_year = create(:convention_year, year: 2010, convention: con2)

    visit("conventions")

    expect(page).to have_content con.name
    click_link con.name
    expect(page).to have_content con.name
    expect(page).to have_content con.description
    expect(page).to have_content con_year.year
    expect(page).not_to have_content con2_year.year
  end
end
