require 'rails_helper'

def fill_in_new_convention_year(options={})
  options[:startYear] ||= "2015"
  options[:startMonth] ||= "May"
  options[:startDay] ||= "22"
  options[:finishYear] ||= "2015"
  options[:finishMonth] ||= "May"
  options[:finishDay] ||= "27"
  options[:location] ||= "Mars"

  select options[:convention].name, from: "Convention"
  fill_in "Location", with: options[:location]
  select options[:startMonth], from: "convention_year_start_2i"
  select options[:startDay], from: "convention_year_start_3i"
  select options[:startYear], from: "convention_year_start_1i"
  select options[:finishMonth], from: "convention_year_finish_2i"
  select options[:finishDay], from: "convention_year_finish_3i"
  select options[:finishYear], from: "convention_year_finish_1i"
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
    end
  end
end
