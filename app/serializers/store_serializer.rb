class StoreSerializer < ApplicationSerializer
  attributes :store_id, :name, :address, :description, :open_time, :close_time, :dist

  has_many :store_images
  has_many :happyhours
  has_many :hash_tags

  def dist
    object.try(:dist).try(:round, 2)
  end

  def store_id
    object.id
  end
end
