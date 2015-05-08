class AddConventionRefToConventionYear < ActiveRecord::Migration
  def change
    add_reference :convention_years, :convention, index: true, foreign_key: true
  end
end
