require 'rails_helper'

describe "Photo shoot update" do
  let!(:con) { create(:convention) }
  let!(:con_year) { create(:convention_year, convention: con) }
  let!(:ps) { create(:photo_shoot, convention_year: con_year) }

  context "with valid parameters" do
    it "updates the photo shoot" do
      visit("photo_shoots/" + ps.id.to_s)
      click_link "Edit"

      fill_in "Series", with: "We have a new series to do"
      click_button "Submit"

      expect(page).to have_content "Photo shoot successfully updated"
      expect(page).to have_content "We have a new series to do"
    end
  end

  context "with invalid parameters" do
    it "does not update the photo shoot" do
      visit("photo_shoots/" + ps.id.to_s)
      click_link "Edit"

      fill_in "Series", with: ""
      click_button "Submit"

      expect(page).to have_content "Could not update photo shoot"
    end
  end
end
