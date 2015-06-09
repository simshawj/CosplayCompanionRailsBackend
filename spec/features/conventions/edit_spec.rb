require 'rails_helper'

def visit_edit_convention(options={})
  options[:con] ||= create(:convention)
  options[:address] ||= "/conventions/" + options[:con].id.to_s
  options[:selector] ||= ".main-content"

  visit options[:address]

  within :css, options[:selector] do
    click_link "Edit"
  end

  options[:con]
end

def fill_in_edit_con_form(options={})
  options[:con] ||= build_stubbed(:convention)
  options[:name] ||= option[:con].name
  options[:description] ||= options[:con].description

  fill_in "Name", with: options[:name]
  fill_in "Description", with: options[:description]
  click_button "Submit"
end

describe "updating conventions" do
  context "from show page" do
    it "updates a convention with valid attributes" do
      con = visit_edit_convention
      fill_in_edit_con_form con: con, name: "A changed convention"

      expect(page).to have_content "Convention updated"
      expect(page).to have_content "A changed convention"
    end

    it "does not update the convention without a name" do
      con = visit_edit_convention
      fill_in_edit_con_form con:con, name: ""

      expect(page).to have_content "Failed to update convention"
      expect(page).to have_content "Name can't be blank"
    end
  end

  context "from index page" do
    let(:con) { create(:convention) }
    let(:id_string) {"#" + con.id_safe_name }
    context "with javascript disabled" do
      before(:each) { visit_edit_convention selector: id_string, con: con, address: "/conventions" }
      it "updates the convention with valid attributes" do
        fill_in_edit_con_form con: con, name: "A changed convention"

        expect(page).to have_content "Convention updated"
        expect(page).to have_content "A changed convention"
      end
      it "does not update the convention without a name" do
        fill_in_edit_con_form con: con, name: ""

        expect(page).to have_content "Failed to update convention"
        expect(page).to have_content "Name can't be blank"
      end
    end

    context "with javascript enabled", js: true do
      before(:each) { visit_edit_convention selector: id_string, con: con, address: "/conventions" }
      it "brings up a modal" do
        expect(page).to have_selector("#modifyConModal", visible: true)
      end
      it "updates the convention with valid attributes" do
        within "#modifyConModal" do
          fill_in_edit_con_form con: con, name: "A changed convention"
        end

        expect(page).to have_content "Convention updated"
        expect(page).to have_content "A changed convention"
      end
      it "does not update the convention without a name" do
        within "#modifyConModal" do
          fill_in_edit_con_form con: con, name: ""
        end

        expect(page).to have_content "Name can't be blank"
      end
    end

  end
end
