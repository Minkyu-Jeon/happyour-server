class Menu < ApplicationRecord
	has_many :menu_images, inverse_of: :menu, dependent: :destroy

	belongs_to :store, inverse_of: :menus

	accepts_nested_attributes_for :menu_images, allow_destroy: true
end
