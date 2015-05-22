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
      redirect_to new_convention_year_path, error: "Could not create convention year"
    end
  end

  def edit
    begin
      @convention_year = ConventionYear.find(params[:id])
    rescue
      redirect_to convention_years_path, error: "Could not retrieve convention year to edit"
    end
  end

  def update
    @convention_year = ConventionYear.find(params[:id])
    if @convention_year.update(convention_year_params)
      redirect_to convention_years_path, success: "Convention year successfully updated"
    else
      flash[:error] = "Unable to update convention year"
      render :edit
    end
  end

  def convention_year_params
    params.require(:convention_year).permit(:year, :start, :days, :convention_id)
  end

end
