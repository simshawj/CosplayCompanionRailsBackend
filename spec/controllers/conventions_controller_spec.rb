require 'rails_helper'

describe ConventionsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_token) { user.create_new_auth_token }
  let(:second_user) { FactoryGirl.create(:user) }
  let(:second_user_token) { second_user.create_new_auth_token }
  let(:invalid_convention_attribs) { FactoryGirl.attributes_for(:convention, name: nil) }
  let(:convention_attribs) { FactoryGirl.attributes_for(:convention) }
  let(:convention) { FactoryGirl.create(:convention, user: user) }
  let(:id) { convention.id }
  let(:second_valid_convention_name) { "A new convention" }
  let(:second_valid_convention_attribs) { FactoryGirl.attributes_for(:convention, name: second_valid_convention_name) }

  describe "GET #index" do
    context "as json" do
      before(:each) { 
        convention
        get :index, format: :json
      }
      it "responds with the convention as json" do
        expect(response.body).to eq([convention].to_json)
      end
    end
  end

  describe "POST #create" do
    context "as JSON" do
      context "not signed in" do
        context "with a valid convention" do
          it "returns a status code of 401" do
            post :create, params: { convention: convention_attribs }, format: :json
            expect(response.status).to eq(401)
          end
          it "saves a Convention" do
            expect{post :create, params: { convention: convention_attribs }, format: :json}.not_to change{Convention.count}
          end
        end
        context "with an invalid convention" do
          it "returns a status code of 401" do
            post :create, params: { convention: invalid_convention_attribs }, format: :json
            expect(response.status).to eq(401)
          end
          it "does not save a Convention" do
            expect{post :create, params: { convention: invalid_convention_attribs }, format: :json}.not_to change{Convention.count}
          end
        end
      end
      
      context "signed in" do
        before(:each) do
          @request.headers.merge!(user_token)
        end
        context "with a valid convention" do
          it "returns a status code of 201" do
            post :create, params: { convention: convention_attribs }, format: :json
            expect(response.status).to eq(201)
          end
          it "saves a Convention" do
            expect{post :create, params: { convention: convention_attribs }, format: :json}.to change{Convention.count}.by(1)
          end
        end
        context "with an invalid convention" do
          it "returns a status code of 422" do
            post :create, params: { convention: invalid_convention_attribs }, format: :json
            expect(response.status).to eq(422)
          end
          it "does not save a Convention" do
            expect{post :create, params: { convention: invalid_convention_attribs }, format: :json}.not_to change{Convention.count}
          end
        end
      end
    end
  end

  describe "GET #show" do
    #TODO: Come back and setup as json
  end

  describe "PUT #update" do
    context "using JSON" do
      context "not signed in" do
        context "with valid attributes" do
          before(:each) {put :update, params: { id: id, convention: second_valid_convention_attribs }, format: :json}
          it "responds with a 401 status" do
            expect(response.status).to eq(401)
          end
          it "updates the convention" do
            convention.reload
            expect(convention.name).to eq("Test Convention")
          end
        end

        context "with invalid attributes" do
          before(:each) {put :update, params: { id: id, convention: invalid_convention_attribs }, format: :json}
          it "responds with a 401 status" do
            expect(response.status).to eq(401)
          end
          it "does not update the convention" do
            convention.reload
            expect(convention.name).to eq("Test Convention")
          end
        end
      end
      
      context "signed in" do
        context "with valid attributes" do
          before(:each) do
            @request.headers.merge!(user_token)
            put :update, params: { id: id, convention: second_valid_convention_attribs }, format: :json
          end
          it "responds with a 200 status" do
            expect(response.status).to eq(200)
          end
          it "updates the convention" do
            convention.reload
            expect(convention.name).to eq(second_valid_convention_name)
          end
        end

        context "with invalid attributes" do
          before(:each) do
            @request.headers.merge!(user_token)
            put :update, params: { id: id, convention: invalid_convention_attribs }, format: :json
          end
          it "responds with a 422 status" do
            expect(response.status).to eq(422)
          end
          it "does not update the convention" do
            convention.reload
            expect(convention.name).to eq("Test Convention")
          end
        end

        context "as a second user" do
          before(:each) do
            @request.headers.merge!(second_user_token)
            put :update, params: { id: id, convention: second_valid_convention_attribs }, format: :json
          end
          it "responds with a 401 status" do
            expect(response.status).to eq(401)
          end
          it "does not update the convention" do
            convention.reload
            expect(convention.name).to eq("Test Convention")
          end
        end
      end
    end
  end
end

