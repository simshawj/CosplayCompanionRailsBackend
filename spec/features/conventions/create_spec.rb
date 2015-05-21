require 'rails_helper'

describe "Convention creation" do
  it "creates a new convention from conventions/new" do
    visit ("conventions/new")
    fill_in "Name", with: "A Test Convention"
    fill_in "Description", with: "A nonexistant convention that is used to test"
    click_button "Submit"

    expect(page).to have_content "Conventions"
    expect(page).to have_content "Convention successfully created"
  end
end
