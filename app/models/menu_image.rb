class MenuImage < ActiveRecord::Base
	belongs_to :menu, inverse_of: :menu_images
end