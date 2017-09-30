class ReviewImageSerializer < ApplicationSerializer
  attributes :url

  def url
    object.url.try(:url)
  end
end
