class PhotoShoot < ActiveRecord::Base
  belongs_to :convention_year

  validates :series, presence: true
  validates :start, presence: true
  validates :location, presence: true
  validates :convention_year, presence: true
  validates :series, uniqueness: { scope: [ :start, :convention_year ], message: "already has a photo shoot at that time for that series." }
  validate :must_happen_during_convention

  def must_happen_during_convention
    if convention_year.present? && start.present?
      day_zero = convention_year.start - 1
      last_day = convention_year.start + convention_year.days - 1
      if (start < day_zero || start > last_day)
        errors.add(:start, "must take place during the convention")
      end
    end
  end

end
