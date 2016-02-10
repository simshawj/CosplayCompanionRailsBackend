require 'rails_helper'

describe "routing for convention years" do
  let(:convention) { FactoryGirl.create(:convention) }
  let(:convention_year) { FactoryGirl.create(:convention_year, convention: convention) }

  it "doesn't route DELETE /convention_years/:id" do
    expect(:delete => "/convention_years/#{convention_year.id.to_s}").not_to be_routable
  end

  it "routes get /conventions/{convention.id}/convention_years.json to convention_years#index" do
    expect(:get => "/conventions/#{convention.id.to_s}/convention_years.json").to route_to("convention_years#index", format: "json", convention_id:"#{convention.id}")
  end
  it "routes post /conventions/{convention.id}/convention_years.json to convention_years#create" do
    expect(:post => "/conventions/#{convention.id.to_s}/convention_years.json").to route_to("convention_years#create", format: "json", convention_id:"#{convention.id}")
  end
  it "routes put /convention_years/{convention_year.id}.json to convention_years#update" do
    expect(:put => "/convention_years/#{convention_year.id.to_s}.json").to route_to("convention_years#update", format: "json", id:"#{convention_year.id}")
  end

  it "does not route put /conventions/{convention.id}/convention_years/{convention_year.id}.json" do
    expect(:put => "/conventions/#{convention.id.to_s}/convention_years/#{convention_year.id.to_s}.json").not_to be_routable
  end
  it "does not route get /convention_years.json" do
    expect(:get => "/convention_years.json").not_to be_routable
  end
  it "does not route post /convention_years.json" do
    expect(:post => "/convention_years.json").not_to be_routable
  end
  it "does not route get /conventions/{convention.id}/convention_years" do
    expect(:get => "/conventions/#{convention.id.to_s}/convention_years").not_to be_routable
  end
  it "does not route post /conventions/{convention.id}/convention_years" do
    expect(:post => "/conventions/#{convention.id.to_s}/convention_years").not_to be_routable
  end
  it "does not route put /convention_years/{convention_year.id}" do
    expect(:put => "/convention_years/#{convention_year.id.to_s}").not_to be_routable
  end
end
