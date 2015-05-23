class ConventionYear < ActiveRecord::Base
  belongs_to :convention
  has_many :photo_shoots

  validates :year, presence: true, numericality: { only_integer: true, greater_than: 1979 }
  validates :year, uniqueness: { scope: :convention, message: "already has a date for that year" }
  validates :days, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 15 }
  validates :start, presence: true
  validates :convention, presence: true
  validate :start_must_be_a_date

  def start_must_be_a_date
    if not start.is_a?(Date)
      errors.add(:start, "must be a date")
    end
  end

  def full_listing
    convention.name + " " + year.to_s
  end

end
