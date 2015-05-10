require 'rails_helper'

describe ConventionYear do
  it "is invalid without a year" do
    expect(FactoryGirl.build(:convention_year, year: nil)).not_to be_valid
  end

  it "is invalid without a start date" do
    expect(FactoryGirl.build(:convention_year, start: nil)).not_to be_valid
  end

  it "is invalid if start date is not a date object" do
    expect(FactoryGirl.build(:convention_year, start: "A string")).not_to be_valid
    expect(FactoryGirl.build(:convention_year, start: 342)).not_to be_valid
    expect(FactoryGirl.build(:convention_year, start: 3.14)).not_to be_valid
  end

  it "is invalid if year is not a number" do
    expect(FactoryGirl.build(:convention_year, year: "A String")).not_to be_valid
    expect(FactoryGirl.build(:convention_year, year: 3.145)).not_to be_valid
  end

  it "is invalid without a number of days" do
    expect(FactoryGirl.build(:convention_year, days: nil)).not_to be_valid
  end

  it "is invalid if number if days is not a number" do
    expect(FactoryGirl.build(:convention_year, days: "A String")).not_to be_valid
  end

  it "is invalid if number of days is less than one" do
    expect(FactoryGirl.build(:convention_year, days: -10)).not_to be_valid
    expect(FactoryGirl.build(:convention_year, days: 0)).not_to be_valid
  end

  it "is invalid if number of days is greater than 14" do
    expect(FactoryGirl.build(:convention_year, days: 15)).not_to be_valid
  end

  it { should belong_to(:convention) }

  it "is invalid without a convention_id" do
    expect(FactoryGirl.build(:convention_year, convention: nil)).not_to be_valid
  end

  it "is invalid without a year greater than 1980" do
    expect(FactoryGirl.build(:convention_year, year: 1960)).not_to be_valid
  end
  
  it "has a unique year with the same convention" do
    convention = FactoryGirl.create(:convention)
    FactoryGirl.create(:convention_year, convention: convention)
    expect(FactoryGirl.build(:convention_year, convention: convention)).not_to be_valid
  end

  it "is valid if the year is the same but associated to different conventions" do
    FactoryGirl.create(:convention_year)
    expect(FactoryGirl.build(:convention_year, convention: FactoryGirl.create(:convention, name: "Second Convention"))).to be_valid
  end

  it { should have_many(:photo_shoots) }

end

