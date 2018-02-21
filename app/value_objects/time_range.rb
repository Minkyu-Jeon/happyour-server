class TimeRange
  attr_reader :start_time, :end_time

  def initialize(start_time, end_time)
    @start_time, @end_time = start_time, end_time
    valid_format?
    valid_range?
  end

  def in_range?(t)
    start_time <= t && end_time >= t
  end

  def to_s
    "#{start_time} ~ #{end_time}"
  end

  private
  def valid_format?
    regexp = /^\d{2}:\d{2}$/
    regexp.match(start_time) or raise "start_time '#{start_time}' is invalid"
    regexp.match(end_time) or raise "end_time '#{end_time}' is invalid"
  end

  def valid_range?
    to_min = -> (time) { 
      t = time.split(":") 
      t[0].to_i * 60 + t[1].to_i
    }
    start_sec = to_min.call(start_time)
    end_sec = to_min.call(end_time)
    start_sec > end_sec and raise "end_time can't grater then start_time"
  end
end
