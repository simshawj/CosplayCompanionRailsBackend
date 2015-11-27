require 'rails_helper'

describe PhotoShoot do
  it { is_expected.to validate_presence_of(:series) }

  it { is_expected.to validate_presence_of(:start) }

  it { is_expected.to validate_presence_of(:convention_year) }

  it { is_expected.to validate_presence_of(:location) }

  it { is_expected.to belong_to(:convention_year) }

  it "is invalid if start is not a datetime object" do
    expect(build_stubbed(:photo_shoot, start: 329872)).not_to be_valid
    expect(build_stubbed(:photo_shoot, start: "A string")).not_to be_valid
  end

  it "is invalid if the same series is at the same time for that convention" do
    convention = create(:convention_year)
    create(:photo_shoot, convention_year: convention)
    expect(build_stubbed(:photo_shoot, convention_year: convention)).not_to be_valid
  end

  it "is valid if the start and series are the same but at a different convention" do
    convention2 = create(:convention, name: "A second convention")
    con_year1 = create(:convention_year)
    con_year2 = create(:convention_year, convention: convention2)
    create(:photo_shoot, convention_year: con_year1)
    expect(build_stubbed(:photo_shoot, convention_year: con_year2)).to be_valid
  end

  it "is invalid if it happens outside of a convention's timeframe" do
    expect(build_stubbed(:photo_shoot, start: DateTime.strptime("9-20-2015", "%m-%d-%Y"))).not_to be_valid
  end

end

