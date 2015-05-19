class PhotoShootsController < ApplicationController
  def index
    @photo_shoots = PhotoShoot.all
  end

  def new
    @photo_shoot = PhotoShoot.new
  end

  def create
    photo_shoot = PhotoShoot.new(photo_shoot_params)
    if photo_shoot.save
      redirect_to photo_shoots_path, success: "Photo shoot successfully created"
    else
      redirect_to new_photo_shoot_path, error: "Photo shoot could not be created"
    end
  end

  def edit
    begin
      @photo_shoot = PhotoShoot.find(params[:id])
    rescue
      redirect_to photo_shoots_path, error: "Could not find specified photo shoot"
    end
  end

  def update
    @photo_shoot = PhotoShoot.find(params[:id])
    if @photo_shoot.update(photo_shoot_params)
      redirect_to photo_shoots_path, success: "Photo shoot successfully updated"
    else
      flash[:error] = "Could not update photo shoot"
      render :edit
    end
  end

  def photo_shoot_params
    params.require(:photo_shoot).permit(:series, :start, :location, :description, :convention_year_id)
  end
end
