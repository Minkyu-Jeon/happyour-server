class ReviewSerializer < ApplicationSerializer
  attributes :id, :evaluation, :eval_text

  belongs_to :user
  has_many :review_images
end
