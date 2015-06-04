require 'rails_helper'

def create_convention(options={})
  goto_form
  fill_in_form options

end

def goto_form
  visit "/conventions"
  click_link "Add a new convention"
end

def fill_in_form(options={})
  options[:name] ||= "A Test Convention"
  options[:description] ||= "A nonexistant convention that is used to test"

  fill_in "Name", with: options[:name]
  fill_in "Description", with: options[:description]
  click_button "Submit"
end

def check_positive_result
  expect(page).to have_content "Convention successfully created"
  expect(page).to have_content "A Test Convention"
end

describe "Convention creation" do
  context "without Javascript" do
    it "creates a new convention from conventions" do
      create_convention
      check_positive_result
    end

    it "displays an error with no name" do
      create_convention(name: "")
      expect(page).to have_content "Name can't be blank"
    end
  end

  context "with Javascript", js: true do
    it "displays a modal with the form" do
      goto_form
      expect(page).to have_selector("#newConModal", visible: true)
    end
    it "creates a new convention" do
      goto_form
      within("#newConModal") do
        fill_in_form
      end
      check_positive_result
    end
  end

end
