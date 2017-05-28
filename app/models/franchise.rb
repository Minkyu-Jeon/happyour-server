class Franchise < ApplicationRecord
	has_many :franchise_images, inverse_of: :franchise
	has_many :menus, inverse_of: :franchise

	validates :name, :address, presence: true
	validates :oepn_time, :close_time, length: { maximum: 8 }
	validates :code, length: { maximum: 10 }
end
