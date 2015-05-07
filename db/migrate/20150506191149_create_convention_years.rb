class CreateConventionYears < ActiveRecord::Migration
  def change
    create_table :convention_years do |t|
      t.integer :year
      t.date :start
      t.integer :days

      t.timestamps null: false
    end
  end
end
