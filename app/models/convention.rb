class Convention < ActiveRecord::Base
  has_many :convention_years

  mount_uploader :logo, ConventionLogoUploader

  validates :name, presence: true, uniqueness: true

  def id_safe_name
    name.tr(" ", "_")
  end
end
