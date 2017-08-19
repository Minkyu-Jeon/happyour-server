class Review < ApplicationRecord
  belongs_to :order, inverse_of: :reviews

  mount_uploader :url, ReviewUploader
end
