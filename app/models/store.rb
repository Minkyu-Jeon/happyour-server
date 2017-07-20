class Store < ApplicationRecord
	has_many :store_images, inverse_of: :store
	has_many :menus, inverse_of: :store
  has_many :happyhours, inverse_of: :store

	validates :name, :address, presence: true
	validates :open_time, :close_time, length: { maximum: 8 }
	validates :code, length: { maximum: 6 }

  before_save :set_gps

  def self.code
    begin
      code = sprintf("%06d", SecureRandom.random_number(999999))
    end while self.exists?(code: code)
    code
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
