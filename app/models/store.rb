class Store < ApplicationRecord
	has_many :store_images, inverse_of: :store
	has_many :menus, inverse_of: :store

	validates :name, :address, presence: true
	validates :oepn_time, :close_time, length: { maximum: 8 }
	validates :code, length: { maximum: 10 }
end
