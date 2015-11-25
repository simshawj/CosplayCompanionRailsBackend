class AddLogoToCovention < ActiveRecord::Migration
  def change
    add_column :conventions, :logo, :string
  end
end
