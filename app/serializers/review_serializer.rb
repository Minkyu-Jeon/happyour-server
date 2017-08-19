class ReviewSerializer < ApplicationSerializer
  attributes :id, :url, :evaluation, :eval_text

  def url
    object.url.try(:url)
  end
end
