class StoreShowSerializer < ApplicationSerializer
  attributes :name, :address, :description, :tel, :gps, :hash_tags
  has_many :menus, serializer: MenuThumbnailSerializer
  has_many :happyhours

  def menus
    object.menus
  end

  def happyhours
    object.happyhours
  end

  def hash_tags
    object.hash_tags.map(&:tag_name)
  end
end
