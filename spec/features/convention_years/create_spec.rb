require 'rails_helper'

def fill_in_new_convention_year(convention)
  select convention.name, from: "Convention"
  fill_in "Year", with: "2015"
  fill_in "Number of Days", with: "5"
  select "May", from: "convention_year_start_2i"
  select "22", from: "convention_year_start_3i"
  select "2015", from: "convention_year_start_1i"
  click_button "Submit"

  expect(page).to have_content convention.name
  expect(page).to have_content "2015"
  expect(page).to have_content "Convention year successfully created"
end

describe "Convention Year Creation" do
  let!(:convention) { create(:convention) }
  context "with a valid parameters" do
    it "creates the convention_year" do
      visit("convention_years/new")

      fill_in_new_convention_year(convention)
    end
    it "creates a convention_year when starting from the index" do
      visit("convention_years")
      click_link("Add a new year")
      fill_in_new_convention_year(convention)
    end
  end

  context "with no paramters" do
    it "does not create a convention" do
      visit("convention_years/new")
      click_button "Submit"

      expect(page).to have_content "Year can't be blank"
      expect(page).to have_content "Year is not a number"
      expect(page).to have_content "Days can't be blank"
      expect(page).to have_content "Days is not a number"
    end
  end
end
