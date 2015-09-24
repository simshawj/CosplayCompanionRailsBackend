require 'rails_helper'

def fill_in_new_convention_year(options={})
  options[:year] ||= "2015"
  options[:days] ||= "5"
  options[:month] ||= "May"
  options[:day] ||= "22"

  select options[:convention].name, from: "Convention"
  fill_in "Year", with: options[:year]
  fill_in "Number of Days", with: options[:days]
  select options[:month], from: "convention_year_start_2i"
  select options[:day], from: "convention_year_start_3i"
  select options[:year], from: "convention_year_start_1i"
  click_button "Submit"
end

def goto_new_convention
  visit "convention_years"
  click_link "Add a new year"
end

def check_year_positive_result
  expect(page).to have_content convention.name
  expect(page).to have_content "2015"
  expect(page).to have_content "Convention year successfully created"
end

describe "Convention Year Creation" do
  let!(:convention) { create(:convention) }

  context "With JS enabled", js: true do
    context "from convention list" do
      context "with valid parameters" do
        it "creates the convention year" do
          visit "/conventions"
          within("#" + convention.id_safe_name) do
            click_link "Add a year"
          end
          within("#modifyConYearModal") do
            fill_in_new_convention_year convention: convention
          end
          check_year_positive_result
        end
      end
    end
    context "from convention details"
  end

  context "with JS disabled" do
    context "from convention list"
    context "from convention details"

    context "from the convention year list" do
      context "with a valid parameters" do
        it "creates the convention_year" do
          goto_new_convention
          fill_in_new_convention_year convention: convention 
         
          check_year_positive_result
        end
      end

      context "with no paramters" do
        it "does not create a convention" do
          goto_new_convention
          fill_in_new_convention_year convention: convention, days: "" 

          expect(page).to have_content "Days can't be blank"
          expect(page).to have_content "Days is not a number"
        end
      end
    end
  end
end
