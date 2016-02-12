require 'rails_helper'

describe "routing for photo shoots" do
  let(:convention_year) { FactoryGirl.create(:convention_year) }
  let(:photo_shoot) { FactoryGirl.create(:photo_shoot, convention_year: convention_year) }

  it "doesn't route DELETE /photo_shoots/:id" do
    expect(:delete => "/photo_shoots/#{photo_shoot.id.to_s}").not_to be_routable
  end

  it "routes get /convention_years/{convention_year.id}/photo_shoots.json to photo_shoots#index" do
    expect(:get => "/convention_years/#{convention_year.id.to_s}/photo_shoots.json").to route_to("photo_shoots#index", format: "json", convention_year_id: "#{convention_year.id}")
  end
  it "routes post /convention_years/{convention_year.id}/photo_shoots.json to photo_shoots#create" do
    expect(:post => "/convention_years/#{convention_year.id.to_s}/photo_shoots.json").to route_to("photo_shoots#create", format: "json", convention_year_id: "#{convention_year.id}")
  end
  it "routes put /photo_shoots/{photo_shoot.id}.json to photo_shoots#update" do
    expect(:put => "/photo_shoots/#{photo_shoot.id.to_s}.json").to route_to("photo_shoots#update", format: "json", id: "#{photo_shoot.id}")
  end

  it "does not route put /convention_years/{convention_year.id}/photo_shoots/{photo_shoot.id}.json" do
    expect(:put => "/convention_years/#{convention_year.id}/photo_shoots/#{photo_shoot.id.to_s}.json").not_to be_routable
  end
  it "does not route get /photo_shoots.json" do
    expect(:get => "/photo_shoots.json").not_to be_routable
  end
  it "does not route post /photo_shoots.json" do
    expect(:post => "/photo_shoots.json").not_to be_routable
  end
  it "does not route get /convention_years/{convention_year.id}/photo_shoots" do
    expect(:get => "/convention_years/#{convention_year.id.to_s}/photo_shoots").not_to be_routable
  end
  it "does not route post /convention_years/{convention_year.id}/photo_shoots" do
    expect(:post => "/convention_years/#{convention_year.id.to_s}/photo_shoots").not_to be_routable
  end
  it "does not route put /photo_shoots/{photo_shoot.id}" do
    expect(:put => "/photo_shoots/#{photo_shoot.id.to_s}").not_to be_routable
  end
end
