require 'rails_helper'

describe "routing for convention years" do
  let(:convention) { FactoryGirl.create(:convention) }
  let(:convention_year) { FactoryGirl.create(:convention_year, convention: convention) }
  let(:id) { convention_year.id }

  it "doesn't route DELETE /convention_years/:id" do
    expect(:delete => "/convention_years/" + id.to_s).not_to be_routable
  end
end
