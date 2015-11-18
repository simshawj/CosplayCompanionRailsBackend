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
    convention = create(:convention)
    con_year1 = create(:convention_year, convention: convention)
    con_year2 =create(:convention_year, year: 2014, convention: convention)
    create(:photo_shoot, convention_year: con_year1)
    expect(build_stubbed(:photo_shoot, convention_year: con_year2)).to be_valid
  end

  it "is invalid if it happens outside of a convention's timeframe" do
    convention = build_stubbed(:convention_year, year: 2015, start: Date.new(2015,5,5), finish: Date.new(2015,5,5) + 2.days)
    expect(build_stubbed(:photo_shoot, convention_year: convention, start: DateTime.new(2015, 7, 7, 0, 0, 0) )).not_to be_valid
  end

end

