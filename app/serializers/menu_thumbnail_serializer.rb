class MenuThumbnailSerializer < ApplicationSerializer
  attributes :menu_id, :name, :price, :image

  def menu_id
    object.id
  end

  def image
    images.first.try(:url).try(:url)
  end

  private
  def images
    object.menu_images
  end
end
