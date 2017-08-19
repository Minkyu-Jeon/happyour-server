class MenuSerializer < ApplicationSerializer
  attributes :name, :price, :discounted_price

  belongs_to :store

  has_many :menu_images
end
