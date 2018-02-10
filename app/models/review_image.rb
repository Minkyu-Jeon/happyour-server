class ReviewImage < ApplicationRecord
  belongs_to :review, inverse_of: :review_images

  mount_uploader :image, ReviewUploader, mount_on: :url
end
