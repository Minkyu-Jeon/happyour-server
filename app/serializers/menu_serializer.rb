class MenuSerializer < ApplicationSerializer
  attributes :name, :price, :discounted_price

  belongs_to :store

  has_many :menu_images
  has_many :reviews
end
