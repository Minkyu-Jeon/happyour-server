class ReviewImage < ApplicationRecord
  belongs_to :review, inverse_of: :review_images

  mount_uploader :url, ReviewUploader
end
