require 'rails_helper'

describe "show convention year" do
  let(:con) { create(:convention) }
  let(:con_year) { create(:convention_year, convention: con) }
  it "displays the information about the convention year" do
    conlink = con_year.convention.name + " " + con_year.year.to_s
    visit("convention_years")
    click_link conlink
    expect(page).to have_content con.name
    expect(page).to have_content con_year.year
    expect(page).to have_content con_year.start
    expect(page).to have_content con_year.finish
  end
end
