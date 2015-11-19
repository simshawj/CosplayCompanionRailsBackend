class RemoveYearFromConventionYear < ActiveRecord::Migration
  def change
    remove_column :convention_years, :year
  end
end
