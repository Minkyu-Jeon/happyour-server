class StoreImage < ActiveRecord::Base
	belongs_to :store, inverse_of: :store_images

  mount_uploader :image, StoreImageUploader, mount_on: :url

  def image_url
    image.url
  end
end
