require 'rails_helper'

describe "routing for conventions" do
  let (:convention) { FactoryGirl.create(:convention) }

  it "doesn't route DELETE /conventions/:id" do
    expect(:delete => "/conventions/#{convention.id.to_s}").not_to be_routable
  end

  it "doesn't route /conventions in html" do
    expect(:get => "/conventions").not_to be_routable
  end

  it "does route /conventions.json to index" do
    expect(:get => "/conventions.json").to route_to("conventions#index", format: "json")
  end

  it "doesn't route post /conventions in html" do
    expect(:post => "/conventions").not_to be_routable
  end

  it "does route post /conventions.json to create" do
    expect(:post => "/conventions.json").to route_to("conventions#create", format: "json")
  end

  it "doesn't route put /conventions/1" do
    expect(:put => "/conventions/#{convention.id.to_s}").not_to be_routable
  end

  it "does route put /conventions/1.json to update" do
    expect(:put => "/conventions/#{convention.id.to_s}.json").to route_to("conventions#update", format: "json", id: convention.id.to_s)
  end
end
