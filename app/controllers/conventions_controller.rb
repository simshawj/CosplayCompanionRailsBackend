class ConventionsController < ApplicationController
  def index
    get_all_conventions
    respond_to do |format|
      format.html {}
      format.json {
        render json: @conventions
      }
    end
  end

  def new
    @convention = Convention.new
  end

  def create
    @convention = Convention.new(convention_params)
    if @convention.save
      respond_to do |format|
        format.html { redirect_to conventions_path, success: "Convention successfully created" }
        format.js do
          get_all_conventions
          flash.now[:success] = "Convention successfully created"
        end
      end
    else
      respond_to do |format|
        format.html { flash[:alert] = "There was an error creating the convention" }
        format.js {}
      end
      render new_convention_path
    end
  end

  def show
    begin
      @convention = Convention.find(params[:id]) 
    rescue
      redirect_to conventions_path, alert: "Could not retrieve convention information"
    end
  end

  def edit
    session[:return_to] ||= request.referer
    begin
      @convention = Convention.find(params[:id])
    rescue
      redirect_to conventions_path, alert: "Could not retrieve convention to edit"
    end
  end

  def update
    @convention = Convention.find(params[:id])
    if @convention.update(convention_params)
      respond_to do |format|
        format.html { redirect_to session.delete(:return_to), success: "Convention updated" }
        format.js do
          get_all_conventions
          flash.now[:success] = "Convention updated"
        end
      end
    else
      respond_to do |format|
        format.html { flash[:alert] = "Failed to update convention" }
        format.js {}
      end
      render action: "edit"
    end
  end

  def convention_params
    params.require(:convention).permit(:name, :description)
  end

  private
  def get_all_conventions
    @conventions = Convention.all
  end
end
