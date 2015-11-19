require 'rails_helper'

describe ConventionYear do
  it "is invalid without a year" do
    expect(build_stubbed(:convention_year, year: nil)).not_to be_valid
  end

  it "is invalid without a start date" do
    expect(build_stubbed(:convention_year, start: nil)).not_to be_valid
  end

  it "is invalid if start date is not a date object" do
    expect(build_stubbed(:convention_year, start: "A string")).not_to be_valid
    expect(build_stubbed(:convention_year, start: 342)).not_to be_valid
    expect(build_stubbed(:convention_year, start: 3.14)).not_to be_valid
  end

  it "is invalid if year is not a number" do
    expect(build_stubbed(:convention_year, year: "A String")).not_to be_valid
    expect(build_stubbed(:convention_year, year: 3.145)).not_to be_valid
  end

  it "is invalid without a finish date" do
    expect(build_stubbed(:convention_year, finish: nil)).not_to be_valid
  end

  it "is invalid if finish date is not a date object" do
    expect(build_stubbed(:convention_year, start: "A string")).not_to be_valid
    expect(build_stubbed(:convention_year, start: 342)).not_to be_valid
    expect(build_stubbed(:convention_year, start: 3.14)).not_to be_valid
  end

  it "is invalid if it starts after it ends" do
    expect(build_stubbed(:convention_year, finish: Date.strptime("10-19-2015", "%m-%d-%Y"))).not_to be_valid
  end

  it { should belong_to(:convention) }

  it "is invalid without a convention_id" do
    expect(build_stubbed(:convention_year, convention: nil)).not_to be_valid
  end

  it "is invalid without a year greater than 1980" do
    expect(build_stubbed(:convention_year, year: 1960)).not_to be_valid
  end
  
  it "has a unique year with the same convention" do
    convention = create(:convention)
    create(:convention_year, convention: convention)
    expect(build_stubbed(:convention_year, convention: convention)).not_to be_valid
  end

  it "is valid if the year is the same but associated to different conventions" do
    create(:convention_year)
    expect(build_stubbed(:convention_year, convention: build_stubbed(:convention, name: "Second Convention"))).to be_valid
  end

  it { should have_many(:photo_shoots) }

  it "returns the Convention name and year when full_listing is called" do
    con_year = build_stubbed(:convention_year)
    expect(con_year.full_listing).to eq("Test Convention 2015")
  end

end

