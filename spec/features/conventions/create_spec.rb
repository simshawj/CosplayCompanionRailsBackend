require 'rails_helper'

def create_convention
    fill_in "Name", with: "A Test Convention"
    fill_in "Description", with: "A nonexistant convention that is used to test"
    click_button "Submit"

    expect(page).to have_content "Conventions"
    expect(page).to have_content "Convention successfully created"
end

describe "Convention creation" do
  it "creates a new convention from conventions/new" do
    visit("conventions/new")
    create_convention
  end

  it "creates a new convention from conventions" do
    visit("conventions")
    click_link "Add a new convention"
    create_convention
  end

  it "displays an error with no name" do
    visit("conventions/new")
    fill_in "Description", with: "A nonexistant convention used to test"
    click_button "Submit"

    expect(page).to have_content "Name can't be blank"
  end
end
