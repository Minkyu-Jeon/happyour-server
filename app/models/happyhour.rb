class Happyhour < ApplicationRecord
  belongs_to :store, inverse_of: :happyhours
  validates :day_of_week, inclusion: { in: [0, 1, 2, 3, 4, 5, 6] }
  validates :start_time, :end_time, presence: true, unless: :is_holiday

  before_save :clear_time, if: :is_holiday


  def time_range
    is_holiday || TimeRange.new(start_time, end_time)
  end

  private
  def clear_time
    self.start_time = nil
    self.end_time = nil
  end
end
