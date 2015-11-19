class AddDisplayNameAndLocationToConventionYear < ActiveRecord::Migration
  def up
    add_column :convention_years, :display, :string
    add_column :convention_years, :location, :string
    ConventionYear.find_each do |conventionYear|
      conventionYear.display = "#{conventionYear.convention.name} #{conventionYear.year}"
      conventionYear.save!
    end
  end

  def down
    remove_column :convention_years, :display
    remove_column :convention_years, :location
  end
end
