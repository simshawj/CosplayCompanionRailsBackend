require 'rails_helper'

describe ConventionYear do
  it { is_expected.to validate_presence_of(:location) }

  it { is_expected.to validate_presence_of(:start) }

  it { is_expected.to validate_presence_of(:finish) }

  it { is_expected.to validate_presence_of(:convention) }

  it { should belong_to(:convention) }

  it { should have_many(:photo_shoots) }
  
  it "is invalid if start date is not a date object" do
    expect(build_stubbed(:convention_year, start: "A string")).not_to be_valid
    expect(build_stubbed(:convention_year, start: 342)).not_to be_valid
    expect(build_stubbed(:convention_year, start: 3.14)).not_to be_valid
  end

  it "is invalid if finish date is not a date object" do
    expect(build_stubbed(:convention_year, start: "A string")).not_to be_valid
    expect(build_stubbed(:convention_year, start: 342)).not_to be_valid
    expect(build_stubbed(:convention_year, start: 3.14)).not_to be_valid
  end

  it "is invalid if it starts after it ends" do
    expect(build_stubbed(:convention_year, finish: Date.strptime("10-19-2015", "%m-%d-%Y"))).not_to be_valid
  end
end
