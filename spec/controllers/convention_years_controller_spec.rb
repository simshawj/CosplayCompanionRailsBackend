require 'rails_helper'

describe ConventionYearsController do
  describe "GET #index" do
    it "renders the :index view"
    it "creates a list of convention years"
  end

  describe "GET #new" do
    it "renders the :new view"
    it "creates a new convention year"
  end

  describe "POST #Create" do
    context "with a valid convention year" do
      it "redirects to the :index view"
      it "saves a convention year"
      it "sets flash success message"
    end

    context "with an invalid convention year" do
      it "redirects to the :new view"
      it "does not save the convnetion year"
      it "sets flash error message"
    end
  end

  describe "GET #edit" do
    context "with a valid id" do
      it "renders the :edit view"
      it "retrieves a convention year"
    end

    context "with an invalid id" do
      it "redirects to the :index view"
      it "sets flasah error message"
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "redirects to the :index view"
      it "modifies the convention year"
      it "sets a successful flash message"
    end

    context "with invalid attributes" do
      it "redirects to the :edit view"
      it "does not modify a convention year"
      it "sets an error flash message"
    end
  end

end

