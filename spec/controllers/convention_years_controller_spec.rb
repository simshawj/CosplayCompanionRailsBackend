require 'rails_helper'

describe ConventionYearsController do
  let!(:convention) { create(:convention) }
  let(:convention_year) { create(:convention_year, convention: convention) }
  let(:id) { convention_year.id }
  let(:invalid_attribs) { attributes_for(:convention_year).merge(convention_id: nil) }
  let(:convention_year_attribs) { invalid_attribs.merge(convention_id: convention.id) }
  let(:second_attribs) { attributes_for(:convention_year, finish: Date.today + 7.days).merge(convention_id: convention.id) }

  describe "GET #index" do
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
    it "creates a list of convention years" do
      get :index
      expect(assigns(:convention_years)).to eq([convention_year])
    end
    it "sorts by convention id then by year" do
      con2 = create(:convention, name: "Con2")
      conventionyear2 = create(:convention_year, convention: convention, year: 2000)
      con2year1 = create(:convention_year, convention: con2, year: 2013)
      con2year2 = create(:convention_year, convention: con2, year: 2010)
      get :index
      array = [conventionyear2, convention_year, con2year2, con2year1]
      expect(assigns(:convention_years)).to eq(array)
    end
  end

  describe "GET #new" do
    before(:each) { get :new }
    it "renders the :new view" do
      expect(response).to render_template :new
    end
    it "creates a new convention year" do
      expect(assigns(:convention_year)).to be_a_new(ConventionYear)
    end
  end

  describe "POST #Create" do
    context "with a valid convention year" do
      it "redirects to the :index view" do
        post :create, convention_year: convention_year_attribs
        expect(response).to redirect_to convention_years_path
      end
      it "saves a convention year" do
        expect{post :create, convention_year: convention_year_attribs}.to change{ConventionYear.count}.by(1)
      end
      it "sets flash success message" do
        post :create, convention_year: convention_year_attribs
        expect(flash[:success]).to be_present
      end
    end

    context "with an invalid convention year" do
      it "redirects to the :new view" do
        post :create, convention_year: invalid_attribs
        expect(response).to render_template "new"
      end
      it "does not save the convnetion year" do
        expect{post :create, convention_year: invalid_attribs}.not_to change{ConventionYear.count}
      end
      it "sets flash alert message" do
        post :create, convention_year: invalid_attribs
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "GET #show" do
    context "with a valid id" do
      before(:each) { get :show, id: id }
      it "renders the :show view" do
        expect(response).to render_template :show
      end
      it "retrieves a convention year" do
        expect(assigns(:convention_year)).to eq(convention_year)
      end
    end

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

  describe "GET #edit" do
    context "with a valid id" do
      before(:each) { get :edit, id: id }
      it "renders the :edit view" do
        expect(response).to render_template :edit
      end
      it "retrieves a convention year" do
        expect(assigns(:convention_year)).to eq(convention_year)
      end
    end

    context "with an invalid id" do
      before(:each) do
        convention_year.delete
        get :edit, id: id
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
    context "with valid attributes" do
      it "redirects to the :index view" do
        put :update, id: id, convention_year: second_attribs
        expect(response).to redirect_to convention_years_path
      end
      it "modifies the convention year" do
        put :update, id: id, convention_year: second_attribs
        convention_year.reload
        expect(convention_year.finish).to eq(Date.today + 7.days)
      end
      it "sets a successful flash message" do
        put :update, id: id, convention_year: second_attribs
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid attributes" do
      it "render to the :edit view" do
        put :update, id: id, convention_year: invalid_attribs
        expect(response).to render_template :edit
      end
      it "does not modify a convention year" do
        put :update, id: id, convention_year: invalid_attribs
        convention_year.reload
        expect(convention_year.convention_id).to_not be_nil
      end
      it "sets an alert flash message" do
        put :update, id:id, convention_year: invalid_attribs
        expect(flash[:alert]).to be_present
      end
    end
  end

end

