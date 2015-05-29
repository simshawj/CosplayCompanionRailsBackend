require 'rails_helper'

def edit_convention_year(options={})
  con = create(:convention)
  con_year = create(:convention_year, convention: con)

  options[:days] ||= "10"

  visit "convention_years/" + con_year.id.to_s
  click_link "Edit"

  fill_in "Days", with: options[:days]
  click_button "Submit"

end

describe "Convention year update" do
  context "with valid parameters" do
    it "updates the convention" do
      edit_convention_year days: "10"
      expect(page).to have_content "Convention year successfully updated"
    end
  end
  
  context "with invalid parameters" do
    it "doese not update the convention year" do
      edit_convention_year days: ""
      expect(page).to have_content "Unable to update convention year"
    end
  end
end
