require 'rails_helper'

describe Convention do
  it { is_expected.to validate_presence_of(:name) }

  describe "uniqueness" do
    subject { create(:convention) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  it { is_expected.to have_many(:convention_years) }

  it "returns a string to use in id tags" do
    con = build_stubbed(:convention, name:"I have many spaces")
    expect(con.id_safe_name).to eq("I_have_many_spaces")
  end
end

