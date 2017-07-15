class StoreSerializer < ApplicationSerializer
  attributes :id, :name, :address, :description, :code, :open_time, :close_time, :dist

  has_many :store_images

  def dist
    object.try(:dist).try(:round, 2)
  end
end
