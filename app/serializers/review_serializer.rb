class ReviewSerializer < ApplicationSerializer
  attributes :id, :url, :evaluation, :eval_text

  belongs_to :user

  def url
    object.url.try(:url)
  end
end
