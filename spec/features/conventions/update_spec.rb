require 'rails_helper'

describe "updating conventions" do
  context "valid convention" do
    it "updates a convention" do
      con = create(:convention)

      visit("conventions/" + con.id.to_s)
      click_link "Edit"

      fill_in "Name", with: "A changed convention"
      click_button "Submit"

      expect(page).to have_content "Convention updated"
      expect(page).to have_content "A changed convention"
    end
  end

  context "invalid convention" do
    it "does not update the convention" do
      con = create(:convention)
      name = con.name

      visit("conventions/" + con.id.to_s)
      click_link "Edit"

      fill_in "Name", with: ""
      click_button "Submit"

      expect(page).to have_content "Failed to update convention"
      expect(page).to have_content "Name can't be blank"
    end
  end
end

