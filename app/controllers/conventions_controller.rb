class ConventionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @conventions = Convention.all
    respond_to do |format|
      format.json { render json: @conventions }
    end
  end

  def create
    @convention = Convention.new(convention_params)
    if params[:logo64]
      @convention.logo = parse_png_from_base64(params[:logo64], params[:name])
    end
    if @convention.save
      respond_to do |format|
        format.json { render json: @convention, status: 201 }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @convention.errors.full_messages }, status: 422 }
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
    @convention = Convention.find(params[:id])
    if @convention.update(convention_params)
      respond_to do |format|
        format.json { render json: @convention, status: 200 }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @convention.errors.full_messages }, status: 422 }
      end
    end
  end

  def convention_params
    params.require(:convention).permit(:name, :description, :logo)
  end

  def parse_png_from_base64(image, filename)
    return image if not image.is_a?(String)
    tempfile = Tempfile.new("temp_logo")
    tempfile.binmode
    tempfile.write(Base64.decode64(image))
    tempfile.rewind

    type = "image/png"

    ActionDispatch::Http::UploadedFile.new(
      :tempfile => tempfile,
      :filename => File.basename("#{filename}_logo.png"),
      :type => type)
  end
end
