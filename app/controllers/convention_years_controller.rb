class ConventionYearsController < ApplicationController
  def index
    convention = Convention.find(params[:convention_id])
    @convention_years = convention.convention_years
    render json: @convention_years
  end
  
  def create
    @convention_year = ConventionYear.new(convention_year_params)
    if @convention_year.save
      render json: @convention_year, status: 201
    else
      render json: { errors: @convention_year.errors.full_messages }, status: 422
    end
  end

  def show
    #TODO: Set this to use JSON
    begin
      @convention_year = ConventionYear.find(params[:id])
    rescue
      redirect_to convention_years_path, alert: "Could not retrieve convention year"
    end
  end

  def update
    @convention_year = ConventionYear.find(params[:id])
    if @convention_year.update(convention_year_params)
      render json: @convention_year, status: 200 
    else
      render json: { errors: @convention_year.errors.full_messages }, status: 422 
    end
  end

  def convention_year_params
    params.require(:convention_year).permit(:year, :start, :finish, :convention_id, :location, :display)
  end
end

