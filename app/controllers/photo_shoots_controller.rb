class PhotoShootsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    convention_year = ConventionYear.find(params[:convention_year_id])
    @photo_shoots = convention_year.photo_shoots
    render json: @photo_shoots
  end

  def create
    if current_user
      @photo_shoot = current_user.photo_shoot.build(photo_shoot_params)
      if @photo_shoot.save
        render json: @photo_shoot, status: 201 
      else
        render json: { errors: @photo_shoot.errors.full_messages }, status: 422
      end
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
    if current_user
      @photo_shoot = current_user.photo_shoot.find_by_id(params[:id])
      if @photo_shoot
        if @photo_shoot.update(photo_shoot_params)
          render json: @photo_shoot, status: 200 
        else
          render json: { errors: @photo_shoot.errors.full_messages }, status: 422 
        end
      else
        render json: { errors: "No photo_shoot found for user" }, status: 401
      end
    end
  end

  def photo_shoot_params
    params.require(:photo_shoot).permit(:series, :start, :location, :description, :convention_year_id)
  end
end
