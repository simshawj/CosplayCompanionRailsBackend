require 'rails_helper'

describe ConventionsController do
  let(:invalid_convention_attribs) { FactoryGirl.attributes_for(:convention, name: nil) }
  let(:convention_attribs) { FactoryGirl.attributes_for(:convention) }
  let(:convention) { FactoryGirl.create(:convention) }
  let(:id) { convention.id }
  let(:second_valid_convention_name) { "A new convention" }
  let(:second_valid_convention_attribs) { FactoryGirl.attributes_for(:convention, name: second_valid_convention_name) }

  describe "GET #index" do
    context "as json" do
      before(:each) { 
        convention
        get :index, :format => :json 
      }
      it "responds with the convention as json" do
        expect(response.body).to eq([convention].to_json)
      end
    end
  end

  describe "POST #create" do
    context "as JSON" do
      context "with a valid convention" do
        it "returns a status code of 201" do
          post :create, convention: convention_attribs, :format => :json
          expect(response.status).to eq(201)
        end
      end
      context "with an invalid convention" do
        it "returns a status code of 422" do
          post :create, convention: invalid_convention_attribs, :format => :json
          expect(response.status).to eq(422)
        end
      end
    end
  end

  describe "GET #show" do
    context "with an invalid id" do
      before(:each) do
        convention.delete
        get :show, id: id
      end
      it "redirects to the :index view" do
        expect(response).to redirect_to action: "index"
      end
      it "sets flash alert message" do
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT #update" do
    context "using JSON" do
      context "with valid attributes" do
        it "responds with a 200 status" do
          put :update, id: id, convention: second_valid_convention_attribs, format: :json
          expect(response.status).to eq(200)
        end
      end

      context "with invalid attributes" do
        it "responds with a 422 status" do
          put :update, id: id, convention: invalid_convention_attribs, format: :json
          expect(response.status).to eq(422)
        end
      end
    end
  end
end

