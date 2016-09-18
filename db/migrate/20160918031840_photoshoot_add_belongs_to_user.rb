class PhotoshootAddBelongsToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :photo_shoots do |t|
      t.belongs_to :user, index: true
    end
  end
end
