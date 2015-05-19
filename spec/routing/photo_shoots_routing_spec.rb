require 'rails_helper'

describe "routing for photo shoots" do
  let(:convention_year) { FactoryGirl.create(:convention_year) }
  let(:photo_shoot) { FactoryGirl.create(:photo_shoot, convention_year: convention_year) }
  let(:id) { photo_shoot.id }

  it "doesn't route DELETE /photo_shoots/:id" do
    expect(:delete => "/photo_shoots/" + id.to_s).not_to be_routable
  end
end
