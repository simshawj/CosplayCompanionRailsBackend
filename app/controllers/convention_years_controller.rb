class ConventionYearsController < ApplicationController
  def index
    @convention_years = ConventionYear.all
  end
end
