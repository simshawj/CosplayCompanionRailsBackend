require 'rails_helper'

describe "routing for conventions" do
  let (:convention) { FactoryGirl.create(:convention) }
  let (:id) { convention.id }

  it "doesn't route DELETE /conventions/:id" do
    expect(:delete => "/conventions/" + id.to_s).not_to be_routable
  end

  it "doesn't route /conventions in html" do
    expect(:get => "/conventions").not_to be_routable
  end

  it "does route /conventions.json" do
    expect(:get => "/conventions.json").to be_routable
  end
end
