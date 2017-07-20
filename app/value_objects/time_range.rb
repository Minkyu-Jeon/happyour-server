class TimeRange
  attr_reader :start_time, :end_time

  def initialize(start_time, end_time, is_12=false)
    @start_time, @end_time = start_time, end_time

  end

  def in_range?(t)
    start_time <= t && end_time >= t
  end

  def to_s
    "#{start_time} ~ #{end_time}"
  end
end
