class Convention < ActiveRecord::Base
  has_many :convention_years

  validates :name, presence: true, uniqueness: true
end
