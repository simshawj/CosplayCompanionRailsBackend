class ConventionYear < ActiveRecord::Base
  validates :year, presence: true, numericality: { only_integer: true, greater_than: 1979 }
  validates :days, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 15 }
  validates :start, presence: true
  validate :start_must_be_a_date

  def start_must_be_a_date
    if not start.is_a?(Date)
      errors.add(:start, "must be a Date object")
    end
  end
end
