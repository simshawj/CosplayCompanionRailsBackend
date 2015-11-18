class ChangeConventionYearDaysToEnddate < ActiveRecord::Migration
  class ConventionYear < ActiveRecord::Base
  end

  def up
    add_column :convention_years, :finish, :date
    ConventionYear.find_each do |conventionYear|
      conventionYear.finish = conventionYear.start + conventionYear.days.days
      conventionYear.save!
    end
    remove_column :convention_years, :days
  end

  def down
    add_column :convention_years, :finish, :integer
    ConventionYear.find_each do |conventionYear|
      conventionYear.days = (conventionYear.finish - conventionYear.start).to_i
      conventionYear.save!
    end
    remove_column :convention_years, :finish
  end
end
