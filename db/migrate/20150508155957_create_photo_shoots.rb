class CreatePhotoShoots < ActiveRecord::Migration
  def change
    create_table :photo_shoots do |t|
      t.string :series
      t.datetime :start
      t.string :location
      t.text :description

      t.timestamps null: false
    end
  end
end
