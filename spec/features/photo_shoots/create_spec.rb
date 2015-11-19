require 'rails_helper'

describe "Photo shoot creation" do
  let!(:con_year) { create(:convention_year) }
  context "with valid parameters" do
    it "creates the convention from the index" do
      visit("photo_shoots")
      click_link "Create a photo shoot"

      select con_year.display, from: "Convention Year"
      fill_in "Series", with: "A test series"
      fill_in "Location", with: "End of time"
      fill_in "Description", with: "We're just testing this"
     
      select "October", from: "photo_shoot_start_2i"
      select "22", from: "photo_shoot_start_3i"
      select "2015", from: "photo_shoot_start_1i"

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
