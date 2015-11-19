require 'rails_helper'

describe ConventionYear do
  it "is invalid without a location" do
    expect(build_stubbed(:convention_year, location: nil)).not_to be_valid
  end

  it "is invalid without a start date" do
    expect(build_stubbed(:convention_year, start: nil)).not_to be_valid
  end

  it "is invalid if start date is not a date object" do
    expect(build_stubbed(:convention_year, start: "A string")).not_to be_valid
    expect(build_stubbed(:convention_year, start: 342)).not_to be_valid
    expect(build_stubbed(:convention_year, start: 3.14)).not_to be_valid
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

  it { should have_many(:photo_shoots) }

end

