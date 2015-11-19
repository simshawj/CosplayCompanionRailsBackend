require 'rails_helper'

describe "show photo shoot" do
  let!(:con) { create(:convention) }
  let!(:con_year) { create(:convention_year, convention: con) }
  let!(:ps) { create(:photo_shoot, convention_year: con_year) }

  it "displays the information about the photo shoot" do
    ps_link = ps.series + " @ " + con_year.display + " @ " + ps.location
    visit("photo_shoots")
    click_link ps_link

    expect(page).to have_content con.name
    expect(page).to have_content con_year.start.year
    expect(page).to have_content ps.series
    expect(page).to have_content ps.location
    expect(page).to have_content ps.start
    expect(page).to have_content ps.description
  end
end
