class StoreSerializer < ApplicationSerializer
  attributes :store_id, :name, :promotion_tag, :dist, :hash_tags
  has_one :image

  def dist
    object.try(:dist).try(:round)
  end

  def store_id
    object.id
  end

  def image
    images.try(:first).try(:url).try(:url)
  end

  def hash_tags
    object.hash_tags.map(&:tag_name)
  end

  private
  def images
    object.store_images
  end
end
