require 'rails_helper'

describe "photo_shoot index" do
  let!(:con) { create(:convention) }
  let!(:con_year) { create(:convention_year, convention: con) }
  let!(:photo_shoot) { create(:photo_shoot, convention_year: con_year) }
  it "displays a list of all photo shoots" do
    visit("photo_shoots")

    expect(page).to have_content con.name
    expect(page).to have_content con_year.year
    expect(page).to have_content photo_shoot.series
    expect(page).to have_content photo_shoot.location
  end
end
