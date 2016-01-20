require 'rails_helper'

describe User do
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  describe "uniqueness" do
    subject { create(:user) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  end
end
