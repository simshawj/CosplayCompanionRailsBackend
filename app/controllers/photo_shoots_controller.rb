class PhotoShootsController < ApplicationController
  def index
    if (params[:convention_year_id])
      convention_year = ConventionYear.find(params[:convention_year_id])
      @photo_shoots = convention_year.photo_shoots
    else
      @photo_shoots = PhotoShoot.all
    end
    respond_to do |format|
      format.json { render json: @photo_shoots }
    end
  end

  def create
    @photo_shoot = PhotoShoot.new(photo_shoot_params)
    if @photo_shoot.save
      respond_to do |format|
        format.json { render json: @photo_shoot, status: 201 }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @photo_shoot.errors.full_messages }, status: 422 }
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
    @photo_shoot = PhotoShoot.find(params[:id])
    if @photo_shoot.update(photo_shoot_params)
      respond_to do |format|
        format.json { render json: @photo_shoot, status: 200 }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @photo_shoot.errors.full_messages }, status: 422 }
      end
    end
  end

  def photo_shoot_params
    params.require(:photo_shoot).permit(:series, :start, :location, :description, :convention_year_id)
  end

  def verified_request?
    if request.content_type == "application/json"
      true
    else
      super()
    end
  end
end
