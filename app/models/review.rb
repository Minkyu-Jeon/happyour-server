class Review < ApplicationRecord
  belongs_to :menu, inverse_of: :reviews
  belongs_to :user, inverse_of: :users

  mount_uploader :url, ReviewUploader
end
