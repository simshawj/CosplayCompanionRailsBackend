require 'rails_helper'

describe ConventionYearsController do
  let!(:convention) { create(:convention) }
  let(:convention_year) { create(:convention_year, convention: convention) }
  let(:id) { convention_year.id }
  let(:invalid_attribs) { attributes_for(:convention_year).merge(convention_id: nil) }
  let(:convention_year_attribs) { invalid_attribs.merge(convention_id: convention.id) }
  let(:second_attribs) { attributes_for(:convention_year, finish: Date.today + 7.days).merge(convention_id: convention.id) }

  describe "GET #index" do
    context "as JSON" do
      before(:each) do
        convention_year
      end
      it "responds with JSON" do
        get :index, format: :json
        expect(response.body).to eq([convention_year].to_json)
      end
      it "returns only the convention years for the given convention" do
        convention2 = create(:convention, name: "Second")
        convention2_year = create(:convention_year, convention: convention2)
        get :index, format: :json, convention_id: convention
        expect(response.body).to eq([convention_year].to_json)
      end
    end
  end

  describe "POST #Create" do
    context "as JSON" do
      context "with valid parameters" do
        it "returns a status code of 201" do
          post :create, convention_year: convention_year_attribs, format: :json
          expect(response.status).to eq(201)
        end
      end
      context "with invalid parameters" do
        it "returns a status code of 422" do
          post :create, convention_year: invalid_attribs, format: :json
          expect(response.status).to eq(422)
        end
      end
    end
  end

  describe "GET #show" do
    context "with an invalid id" do
      before(:each) do
        convention_year.delete
        get :show, id: id
      end
      it "redirects to the :index view" do
        expect(response).to redirect_to convention_years_path
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
          put :update, id: id, convention_year: second_attribs, format: :json
          expect(response.status).to eq(200)
        end
      end
      context "with invalid attributes" do
        it "responds with a 422 status" do
          put :update, id: id, convention_year: invalid_attribs, format: :json
          expect(response.status).to eq(422)
        end
      end
    end
  end

end

