class ConventionsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    @conventions = Convention.all
    render json: @conventions
  end

  def create
    if current_user
      @convention = current_user.convention.build(convention_params)

      if params[:logo64]
        @convention.logo = parse_png_from_base64(params[:logo64])
      end
      if @convention.save
        render json: @convention, status: 201
      else
        render json: { errors: @convention.errors.full_messages }, status: 422 
      end
    end
  end

  def show
    #TODO: Should we get rid of this as well since it doesn't return JSON?
    begin
      @convention = Convention.find(params[:id]) 
    rescue
      redirect_to conventions_path, alert: "Could not retrieve convention information"
    end
  end

  def update
    if current_user
      @convention = current_user.convention.find_by_id(params[:id])
      if @convention
        if params[:logo64]
          @convention.logo = parse_png_from_base64(params[:logo64])
        end
        if @convention.update(convention_params)
          render json: @convention, status: 200
        else
          render json: { errors: @convention.errors.full_messages }, status: 422 
        end
      else
        render json: { errors: "No convention found for user" }, status: 401
      end
    end
  end

  def convention_params
    params.require(:convention).permit(:name, :description, :logo)
  end

  def parse_png_from_base64(image)
    return image if not image.is_a?(String)
    tempfile = Tempfile.new("temp_logo")
    tempfile.binmode
    tempfile.write(Base64.decode64(image))
    tempfile.rewind

    type = "image/png"

    ActionDispatch::Http::UploadedFile.new(
      :tempfile => tempfile,
      :filename => File.basename("logo.png"),
      :type => type)
  end
end
