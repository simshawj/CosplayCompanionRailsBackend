class Convention < ApplicationRecord
  has_many :convention_years

  mount_uploader :logo, ConventionLogoUploader

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false

  def id_safe_name
    name.tr(" ", "_")
  end
end
