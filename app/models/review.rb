class Review < ApplicationRecord
  belongs_to :menu, inverse_of: :reviews
  belongs_to :user, inverse_of: :users

  has_many :review_images, inverse_of: :review
end
