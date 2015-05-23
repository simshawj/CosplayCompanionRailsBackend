require 'rails_helper'

describe "Photo shoot creation" do
  let!(:con) { create(:convention) }
  let!(:con_year) { create(:convention_year, convention: con) }
  context "with valid parameters" do
    it "creates the convention from the index" do
      visit("photo_shoots")
      click_link "Create a photo shoot"

      select con_year.full_listing, from: "Convention Year"
      fill_in "Series", with: "A test series"
      fill_in "Location", with: "End of time"
      fill_in "Description", with: "We're just testing this"
      #Since the default covention_year is today, we'll let the photo shoot happen now which should be the default
      
      click_button "Submit"

      expect(page).to have_content "A test series"
      expect(page).to have_content "End of time"
    end
  end

  context "with invalid parameters" do
    it "does not create the convention" do
      visit("photo_shoots")
      click_link "Create a photo shoot"
      click_button "Submit"

      expect(page).to have_content "Series can't be blank"
      expect(page).to have_content "Location can't be blank"

    end
  end
end
