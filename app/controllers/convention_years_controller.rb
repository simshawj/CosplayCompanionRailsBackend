class ConventionYearsController < ApplicationController
  def index
    @convention_years = ConventionYear.all.order(:convention_id, :year)
  end

  def new
    @convention_year = ConventionYear.new
  end

  def create
    @convention_year = ConventionYear.new(convention_year_params)
    if @convention_year.save
      redirect_to convention_years_path, success: "Convention year successfully created"
    else
      flash[:alert] = "Could not create convention year"
      render new_convention_year_path
    end
  end

  def show
    begin
      @convention_year = ConventionYear.find(params[:id])
    rescue
      redirect_to convention_years_path, alert: "Could not retrieve convention year"
    end
  end

  def edit
    begin
      @convention_year = ConventionYear.find(params[:id])
    rescue
      redirect_to convention_years_path, alert: "Could not retrieve convention year to edit"
    end
  end

  def update
    @convention_year = ConventionYear.find(params[:id])
    if @convention_year.update(convention_year_params)
      redirect_to convention_years_path, success: "Convention year successfully updated"
    else
      flash[:alert] = "Unable to update convention year"
      render :edit
    end
  end

  def convention_year_params
    params.require(:convention_year).permit(:year, :start, :finish, :convention_id)
  end
end

