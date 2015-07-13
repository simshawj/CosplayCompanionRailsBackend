module ConventionYearsHelper
  def finish_year_row(index, row)
    div_class = "small-4 columns"
    div_class += " end" if index == row.length
    div_class
  end
end
