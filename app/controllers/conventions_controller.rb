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
      redirect_to action: "index"
    else
      render action: "new"
    end
  end

  def show
    @convention = Convention.find(params[:id]) 
  end

  def convention_params
    params.require(:convention).permit(:name, :description)
  end
end
