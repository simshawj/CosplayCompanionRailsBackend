require 'rails_helper'

describe PhotoShootsController do
  let!(:convention_year) { create(:convention_year) }
  let(:photo_shoot) { create(:photo_shoot, convention_year: convention_year) }
  let(:valid_attribs) { attributes_for(:photo_shoot).merge(convention_year_id: convention_year.id) }
  let(:second_valid_attribs) { attributes_for(:photo_shoot, series: "Another series").merge(convention_id: convention_year.id) }
  let(:invalid_attribs) { valid_attribs.merge(convention_year_id: nil) }
  let(:id) { photo_shoot.id }

  describe "GET #index" do
    context "as json" do
      before(:each) do
        photo_shoot
        get :index, params: { convention_year_id: convention_year.id }, format: :json
      end
      it "responds with a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "returns the convention years in json format" do
        expect(response.body).to eq([photo_shoot].to_json)
      end
    end
  end

  describe "POST #create" do
    context "as JSON" do
      context "with valid parameters" do
        it "responds with a 201 code" do
          post :create, params: { photo_shoot: valid_attribs }, format: :json
          expect(response.status).to eq(201)
        end
      end
      context "with invalid parameters" do
        it "respondsd with a 422 code" do
          post :create, params: { photo_shoot: invalid_attribs }, format: :json
          expect(response.status).to eq(422)
        end
      end
    end
  end

  describe "GET #show" do
    #NYI
  end

  describe "PUT update" do
    context "as JSON" do
      before(:each) { photo_shoot }
      context "with valid parameters" do
        it "responds with a 200 code" do
          put :update, params: { id: id,  photo_shoot: second_valid_attribs }, format: :json
          expect(response.status).to eq(200)
        end
      end
      context "with invalid parameters" do
        it "responds with a 422 code" do
          put :update, params: { id: id, photo_shoot: invalid_attribs }, format: :json
          expect(response.status).to eq(422)
        end
      end
    end
  end
end

