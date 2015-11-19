class ConventionYear < ActiveRecord::Base
  belongs_to :convention
  has_many :photo_shoots

  validates :year, presence: true, numericality: { only_integer: true, greater_than: 1979 }
  validates :year, uniqueness: { scope: :convention, message: "already has a date for that year" }
  validates :start, presence: true
  validates :finish, presence: true
  validates :convention, presence: true
  validates :location, presence: true
  validate :start_must_be_a_date
  validate :finish_must_be_a_date
  validate :finish_must_be_after_start

  def start_must_be_a_date
    if not start.is_a?(Date)
      errors.add(:start, "must be a date")
    end
  end

  def finish_must_be_a_date
    if not finish.is_a?(Date)
      errors.add(:finish, "must be a date")
    end
  end

  def finish_must_be_after_start
    if finish.is_a?(Date) and start.is_a?(Date)
      if finish < start
        errors.add(:finish, "must be after start")
      end
    end
  end

  def full_listing
    convention.name + " " + year.to_s
  end
end
