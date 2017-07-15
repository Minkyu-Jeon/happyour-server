class MenuSerializer < ApplicationSerializer
  attributes :name, :price

  belongs_to :store

  has_many :menu_images
end
