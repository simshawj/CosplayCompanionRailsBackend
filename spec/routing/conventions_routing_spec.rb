require 'rails_helper'

describe "routing for conventions" do
  let (:convention) { FactoryGirl.create(:convention) }
  let (:id) { convention.id }

  it "doesn't route DELETE /conventions/:id" do
    expect(:delete => "/conventions/" + id.to_s).not_to be_routable
  end
end
