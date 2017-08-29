class MenuSerializer < ApplicationSerializer
  attributes :menu_id, :name, :price, :discounted_price

  belongs_to :store

  has_many :menu_images
  has_many :reviews

  def menu_id
    object.id
  end
end
