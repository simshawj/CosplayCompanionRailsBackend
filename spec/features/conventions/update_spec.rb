require 'rails_helper'

def edit_convention(options={})
  con = create(:convention)

  options[:name] ||= con.name
  options[:description] ||= con.description
  options[:address] ||= "conventions/" + con.id.to_s

  visit options[:address]
  click_link "Edit"

  fill_in "Name", with: options[:name]
  fill_in "Description", with: options[:description]
  click_button "Submit"
end

describe "updating conventions" do
  context "valid convention" do
    it "updates a convention" do
      edit_convention(name: "A changed convention")

      expect(page).to have_content "Convention updated"
      expect(page).to have_content "A changed convention"
    end
  end

  context "invalid convention" do
    it "does not update the convention" do
      edit_convention(name: "")

      expect(page).to have_content "Failed to update convention"
      expect(page).to have_content "Name can't be blank"
    end
  end
end

