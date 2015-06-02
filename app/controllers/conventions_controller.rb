class ConventionsController < ApplicationController
  def index
    @conventions = Convention.all
  end

  def new
    @convention = Convention.new
  end

  def create
    @convention = Convention.new(convention_params)
    if @convention.save
      redirect_to conventions_path, success: "Convention successfully created"
    else
      flash[:alert] = "There was an error creating the convention"
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
    begin
      @convention = Convention.find(params[:id])
    rescue
      redirect_to conventions_path, alert: "Could not retrieve convention to edit"
    end
  end

  def update
    @convention = Convention.find(params[:id])
    if @convention.update(convention_params)
      redirect_to conventions_path, success: "Convention updated"
    else
      flash[:alert] = "Failed to update convention"
      render action: "edit"
    end
  end

  def convention_params
    params.require(:convention).permit(:name, :description)
  end
end
