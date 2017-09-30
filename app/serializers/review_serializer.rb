class ReviewSerializer < ApplicationSerializer
  attributes :id, :url, :evaluation, :eval_text

  belongs_to :user
  has_many :review_images

  def url
    object.url.try(:url)
  end
end
