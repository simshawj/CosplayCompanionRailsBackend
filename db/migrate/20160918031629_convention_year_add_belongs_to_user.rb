class ConventionYearAddBelongsToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :convention_years do |t|
      t.belongs_to :user, index: true
    end
  end
end
