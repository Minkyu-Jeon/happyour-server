class StoreImage < ActiveRecord::Base
	belongs_to :store, inverse_of: :store_images
end
