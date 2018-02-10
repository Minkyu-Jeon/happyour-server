class StoreImageSerializer < ApplicationSerializer
  attributes :id, :url

  belongs_to :store

  def store
    object.try(:store)
  end

  def url
    object.image.try(:url)
  end
end
