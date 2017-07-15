class Menu < ApplicationRecord
	has_many :menu_images, inverse_of: :menu
	has_many :orders, inverse_of: :menu

	belongs_to :store, inverse_of: :menus
end
