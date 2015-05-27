require 'rails_helper'

def fill_in_new_convention_year(options={})
  options[:year] ||= "2015"
  options[:days] ||= "5"
  options[:month] ||= "May"
  options[:day] ||= "22"

  visit "convention_years"
  click_link "Add a new year"

  select options[:convention].name, from: "Convention"
  fill_in "Year", with: options[:year]
  fill_in "Number of Days", with: options[:days]
  select options[:month], from: "convention_year_start_2i"
  select options[:day], from: "convention_year_start_3i"
  select options[:year], from: "convention_year_start_1i"
  click_button "Submit"

end

describe "Convention Year Creation" do
  let!(:convention) { create(:convention) }
  context "with a valid parameters" do
    it "creates the convention_year" do
      fill_in_new_convention_year convention: convention 
      
      expect(page).to have_content convention.name
      expect(page).to have_content "2015"
      expect(page).to have_content "Convention year successfully created"
    end
  end

  context "with no paramters" do
    it "does not create a convention" do
      fill_in_new_convention_year convention: convention, days: "" 

      expect(page).to have_content "Days can't be blank"
      expect(page).to have_content "Days is not a number"
    end
  end
end
