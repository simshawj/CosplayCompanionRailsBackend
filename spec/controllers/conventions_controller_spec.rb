require 'rails_helper'

describe ConventionsController do
  describe "GET #index" do
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
    it "creates a list of Conventions" do
      convention = FactoryGirl.create(:convention)
      get :index
      expect(assigns(:conventions)).to eq([convention])
    end
  end

  describe "GET #new" do
    it "renders the :new view" do
      get :new
      expect(response).to render_template :new
    end
    it "creates a new Convention" do
      get :new
      expect(assigns(:convention)).to be_a_new(Convention)
    end
  end

  describe "POST #create" do
    context "with a valid convention" do
        let(:convention) { FactoryGirl.attributes_for(:convention) }
      it "redirects to the :index view" do
        post :create, convention: convention
        expect(response).to redirect_to action: "index"
      end
      it "saves a Convention" do
        expect{post :create, convention: convention}.to change{Convention.count}.by(1)
      end
    end

    context "with an invalid convention" do
      let(:convention) { FactoryGirl.attributes_for(:convention, name: nil) }
      it "redirects to the :new view" do
        post :create, convention: convention
        expect(response).to render_template :new
      end
      it "does not save a Convention" do
        expect{post :create, convention: convention}.not_to change{Convention.count}
      end
      it "sets flash message"
    end
  end

  describe "GET #show" do
    context "with a valid id" do
      let(:convention) { FactoryGirl.create(:convention) }
      before(:each) do
        get :show, id: convention.id
      end
      it "renders the :show view" do
        expect(response).to render_template :show
      end
      it "retrieves a Convention" do
        expect(assigns(:convention)).to eq(convention)
      end
    end

    context "with an invalid id" do
      before(:each) do
        convention = FactoryGirl.create(:convention)
        id = convention.id
        convention.delete
        get :show, id: id
      end
      it "redirects to the :index view" do
        expect(response).to redirect_to action: "index"
      end
      it "sets flash message"
    end
  end

  describe "GET #edit" do
    it "renders the :edit iview"
    it "retrieves a Convention"
  end

  describe "PUT #update" do
    it "renders the :index view"
    it "modifies a Convention"
  end

  describe "DELETE #destroy" do
    it "redirects to the :index view"
    it "displays a flash message saying you cannot delete Conventions"
    it "does nothing to the number of Conventions"
  end
end
