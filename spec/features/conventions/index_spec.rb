require 'rails_helper'

describe "index.html.erb" do
  it "displays each convention's name" do
    create(:convention, name: "Convention 1")
    create(:convention, name: "Convention 2")
    create(:convention, name: "Convention 3")

    visit("conventions")
    expect(page).to have_content "Convention 1"
    expect(page).to have_content "Convention 2"
    expect(page).to have_content "Convention 3"
  end
end
