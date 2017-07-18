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

  private
  def set_gps
    self.gps = Addr2Coord.new(address).call
  end
end
