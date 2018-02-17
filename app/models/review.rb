class Review < ApplicationRecord
  belongs_to :store, inverse_of: :reviews
  belongs_to :user, inverse_of: :reviews

  has_many :review_images, inverse_of: :review
  has_many :review_evaluations, inverse_of: :review
end
