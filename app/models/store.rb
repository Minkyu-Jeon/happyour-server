class Store < ApplicationRecord
	has_many :store_images, inverse_of: :store
	has_many :menus, inverse_of: :store
  has_many :happyhours, inverse_of: :store
  has_many :hash_tags, inverse_of: :store

	validates :name, :address, presence: true
	validates :open_time, :close_time, length: { maximum: 8 }
	validates :code, length: { maximum: 6 }

  scope :by_dist, -> { order("dist") }

  before_save :set_gps

  def self.code
    begin
      code = sprintf("%06d", SecureRandom.random_number(999999))
    end while self.exists?(code: code)
    code
  end

  def self.select_with_args(sql, args)
    query = sanitize_sql_array([sql, args].flatten)
    select(query)
  end

  def self.distance_from(gps)
    gpss = gps.split(",")

    lat = gpss.first
    lng = gpss.last

    select_dist = <<-SELECT_DIST
    (
      111.111 * (
        DEGREES(ACOS(COS(RADIANS(:lat1))
          * COS(RADIANS(lat2))
          * COS(RADIANS(:lng1 - lng2))
          + SIN(RADIANS(:lat1))
          * SIN(RADIANS(lat2))))
      )
    ) dist
    SELECT_DIST

    join_str = <<-JOIN_STR
      INNER JOIN(
        #{Store.select("id, SUBSTRING_INDEX(gps, ',', 1) lat2, SUBSTRING_INDEX(gps, ',', -1) lng2").to_sql}
      ) B ON #{Store.table_name}.id = B.id
    JOIN_STR

    Store.select_with_args("#{self.table_name}.*, #{select_dist}", {lat1: lat, lng1: lng})
         .joins(join_str)
  end

  def is_available_time?(t)
    wday = t.wday # 오늘 요일
    c_time_formatted = t.strftime("%T") # 현재 시간

    h = happyhours.where(day_of_week: wday, is_holiday: false)
    usable_hour = h.where("start_time <= :time AND end_time >= :time", {time: c_time_formatted}).order(end_time: :desc)

    usable_hour.exists?
  end

  private
  def set_gps
    self.gps = Addr2Coord.new(address).call
  end
end
