require 'rails_helper'

describe PhotoShootsController do
  let!(:convention_year) { create(:convention_year) }
  let(:photo_shoot) { create(:photo_shoot, convention_year: convention_year) }
  let(:valid_attribs) { attributes_for(:photo_shoot).merge(convention_year_id: convention_year.id) }
  let(:second_valid_attribs) { attributes_for(:photo_shoot, series: "Another series").merge(convention_id: convention_year.id) }
  let(:invalid_attribs) { valid_attribs.merge(convention_year_id: nil) }
  let(:id) { photo_shoot.id }

  describe "GET #index" do
    before(:each) { get :index }
    it "renders the :index view" do 
      expect(response).to render_template :index
    end
    it "creates a list of photoshoots" do
      expect(assigns(:photo_shoots)).to eq([photo_shoot])
    end
  end

  describe "GET #new" do
    before(:each) { get :new }
    it "renders the :new template" do
      expect(response).to render_template :new
    end
    it "creates a new photo shoot" do
      expect(assigns(:photo_shoot)).to be_a_new(PhotoShoot)
    end
  end

  describe "POST #create" do
    context "with a valid photo shoot" do
      it "redirects to the :index view" do
        post :create, photo_shoot: valid_attribs
        expect(response).to redirect_to photo_shoots_path
      end
      it "saves a photoshoot" do
        expect{post :create, photo_shoot: valid_attribs}.to change{PhotoShoot.count}.by(1)
      end
      it "sets a flash :success message" do
        post :create, photo_shoot: valid_attribs
        expect(flash[:success]).to be_present
      end
    end

    context "with an invalid photo shoot" do
      it "redirects to the :new view" do
        post :create, photo_shoot: invalid_attribs
        expect(response).to render_template :new
      end
      it "does not save a photo shoot" do
        expect{post :create, photo_shoot: invalid_attribs}.not_to change{PhotoShoot.count}
      end
      it "sets a flash :alert message" do
        post :create, photo_shoot: invalid_attribs
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
      it "retrieves a photo_shoot" do
        expect(assigns(:photo_shoot)).to eq(photo_shoot)
      end
    end

    context "with an invalid id" do
      before(:each) do
        photo_shoot.delete
        get :show, id: id
      end
      it "redirects to the :index view" do
        expect(response).to redirect_to photo_shoots_path
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
      it "retrieves a photo shoot" do
        expect(assigns(:photo_shoot)).to eq(photo_shoot)
      end
    end

    context "with an invalid id" do
      before(:each) do
        photo_shoot.delete
        get :edit, id: id
      end
      it "redirects to the :index view" do
        expect(response).to redirect_to photo_shoots_path
      end
      it "sets a flash alert message" do
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT update" do
    context "with valid attributes" do
      it "redirects to the :index view" do
        put :update, id: id, photo_shoot: second_valid_attribs
        expect(response).to redirect_to photo_shoots_path
      end
      it "modifies the photo shoot" do
        put :update, id: id, photo_shoot: second_valid_attribs
        photo_shoot.reload
        expect(photo_shoot.series).to eq("Another series")
      end
      it "sets a successful flash message" do
        put :update, id: id, photo_shoot: second_valid_attribs
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid attributes" do
      it "renders the :edit view" do
        put :update, id: id, photo_shoot: invalid_attribs
        expect(response).to render_template :edit
      end
      it "does not modify the photo shoot" do
        put :update, id: id, photo_shoot: invalid_attribs
        photo_shoot.reload
        expect(photo_shoot.convention_year_id).not_to be_nil
      end
      it "sets an alert flash message" do
        put :update, id: id, photo_shoot: invalid_attribs
        expect(flash[:alert]).to be_present
      end
    end
  end
end

