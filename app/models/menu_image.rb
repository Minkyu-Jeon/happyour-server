class MenuImage < ApplicationRecord
	belongs_to :menu, inverse_of: :menu_images

  mount_uploader :image, MenuImageUploader, mount_on: :url

  scope :by_display_order, -> { order(:display_order) }
end
