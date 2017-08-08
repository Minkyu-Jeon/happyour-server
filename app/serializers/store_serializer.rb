class StoreSerializer < ApplicationSerializer
  attributes :id, :name, :address, :description, :code, :open_time, :close_time, :dist

  has_many :store_images
  has_many :happyhours

  def dist
    object.try(:dist).try(:round, 2)
  end
end
