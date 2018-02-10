class ReviewImageSerializer < ApplicationSerializer
  attributes :url

  def url
    object.image.try(:url)
  end
end
