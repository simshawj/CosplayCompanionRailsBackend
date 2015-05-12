class FixUniquenessRaceCondition < ActiveRecord::Migration
  def change
    add_index :conventions, :name, unique: true
    add_index :convention_years, [:convention_id, :year], unique: true
    add_index :photo_shoots, [:series, :start, :convention_year_id], unique: true
  end
end
