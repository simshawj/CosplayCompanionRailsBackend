require 'rails_helper'

describe Convention do
  it "is invalid without a name" do
    expect(FactoryGirl.build(:convention, name: nil)).not_to be_valid
  end

  it "is invalid with an empty name" do
    expect(FactoryGirl.build(:convention, name: "")).not_to be_valid
  end

  it "is unique" do
    FactoryGirl.create(:convention)
    expect(FactoryGirl.build(:convention)).not_to be_valid
  end

  it { should have_many(:convention_years) }
end
