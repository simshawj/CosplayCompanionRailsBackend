class AddConventionYearRefToPhotoShoot < ActiveRecord::Migration
  def change
    add_reference :photo_shoots, :convention_year, index: true, foreign_key: true
  end
end
