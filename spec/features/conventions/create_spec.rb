require 'rails_helper'

def create_convention(options={})
  options[:name] ||= "A Test Convention"
  options[:description] ||= "A nonexistant convention that is used to test"

  visit "conventions"
  click_link "Add a new convention"

  fill_in "Name", with: options[:name]
  fill_in "Description", with: options[:description]
  click_button "Submit"

end

describe "Convention creation" do
  it "creates a new convention from conventions" do
    create_convention
    expect(page).to have_content "Convention successfully created"
  end

  it "displays an error with no name" do
    create_convention(name: "")
    expect(page).to have_content "Name can't be blank"
  end
end
