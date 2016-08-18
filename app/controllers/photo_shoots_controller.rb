class PhotoShootsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    convention_year = ConventionYear.find(params[:convention_year_id])
    @photo_shoots = convention_year.photo_shoots
    render json: @photo_shoots
  end

  def create
    @photo_shoot = PhotoShoot.new(photo_shoot_params)
    if @photo_shoot.save
      render json: @photo_shoot, status: 201 
    else
      render json: { errors: @photo_shoot.errors.full_messages }, status: 422
    end
  end

  def show
    begin
      @photo_shoot = PhotoShoot.find(params[:id])
    rescue
      redirect_to photo_shoots_path, alert: "Couldnot find specified photo shoot"
    end
  end

  def update
    @photo_shoot = PhotoShoot.find(params[:id])
    if @photo_shoot.update(photo_shoot_params)
      render json: @photo_shoot, status: 200 
    else
      render json: { errors: @photo_shoot.errors.full_messages }, status: 422 
    end
  end

  def photo_shoot_params
    params.require(:photo_shoot).permit(:series, :start, :location, :description, :convention_year_id)
  end
end
