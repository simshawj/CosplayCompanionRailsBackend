require 'rails_helper'

describe "Show Convention" do
  it "displays the information about the convention" do
    con = create(:convention)

    visit("conventions")

    expect(page).to have_content con.name
    click_link con.name
    expect(page).to have_content con.name
    expect(page).to have_content con.description
  end
end
