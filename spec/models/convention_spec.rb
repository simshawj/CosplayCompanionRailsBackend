require 'rails_helper'

describe Convention do
  it "is invalid without a name" do
    expect(build_stubbed(:convention, name: nil)).not_to be_valid
  end

  it "is invalid with an empty name" do
    expect(build_stubbed(:convention, name: "")).not_to be_valid
  end

  it "is unique" do
    create(:convention)
    expect(build_stubbed(:convention)).not_to be_valid
  end

  it { should have_many(:convention_years) }

  it "returns a string to use in id tags" do
    con = build_stubbed(:convention, name:"I have many spaces")
    expect(con.id_safe_name).to eq("I_have_many_spaces")
  end
end

