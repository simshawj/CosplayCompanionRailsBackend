require 'rails_helper'

describe PhotoShoot do
  it "is inavlid wihtout a series" do
    expect(build_stubbed(:photo_shoot, series: nil)).not_to be_valid
    expect(build_stubbed(:photo_shoot, series: "")).not_to be_valid
  end

  it "is invalid without a start" do
    expect(build_stubbed(:photo_shoot, start: nil)).not_to be_valid
  end

  it "is invalid if start is not a datetime object" do
    expect(build_stubbed(:photo_shoot, start: 329872)).not_to be_valid
    expect(build_stubbed(:photo_shoot, start: "A string")).not_to be_valid
  end

  it "is invalid without a location" do
    expect(build_stubbed(:photo_shoot, location: nil)).not_to be_valid
    expect(build_stubbed(:photo_shoot, location: "")).not_to be_valid
  end

  it { should belong_to(:convention_year) }

  it "is invalid without a convention_year" do
    expect(build_stubbed(:photo_shoot, convention_year: nil)).not_to be_valid
  end

  it "is invalid if the same series is at the same time for that convention" do
    convention = create(:convention_year)
    create(:photo_shoot, convention_year: convention)
    expect(build_stubbed(:photo_shoot, convention_year: convention)).not_to be_valid
  end

  it "is valid if the start and series are the same but at a different convention" do
    con_year1 = create(:convention_year)
    con_year2 = create(:convention_year2)
    create(:photo_shoot, convention_year: con_year1)
    expect(build_stubbed(:photo_shoot, convention_year: con_year2, start: Date.strptime("10-21-2016", "%m-%d-%Y"))).to be_valid
  end

  it "is invalid if it happens outside of a convention's timeframe" do
    expect(build_stubbed(:photo_shoot, start: DateTime.strptime("9-20-2015", "%m-%d-%Y"))).not_to be_valid
  end

end

