class MenuImage < ActiveRecord::Base
	belongs_to :menu, inverse_of: :menu_images

  mount_uploader :url, MenuImageUploader
end
