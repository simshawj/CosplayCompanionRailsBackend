require 'rails_helper'

def edit_convention_year(options={})
  con = create(:convention)
  con_year = create(:convention_year, convention: con)

  options[:finishDay] ||= "30"

  visit "convention_years/" + con_year.id.to_s
  click_link "Edit"

  select options[:finishDay], from: "convention_year_finish_3i"
  click_button "Submit"

end

describe "Convention year update" do
  context "with valid parameters" do
    it "updates the convention" do
      edit_convention_year 
      expect(page).to have_content "Convention year successfully updated"
    end
  end
end
