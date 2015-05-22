require 'rails_helper'

describe "Convention year update" do
  let(:con) { create(:convention) }
  let(:con_year) { create(:convention_year, convention: con) }

  context "with valid parameters" do
    it "updates the convention" do
      visit("convention_years/" + con_year.id.to_s)
      click_link "Edit"

      fill_in "Year", with: "2010"
      click_button "Submit"

      expect(page).to have_content "Convention year successfully updated"
      expect(page).to have_content "2010"
    end
  end
end
