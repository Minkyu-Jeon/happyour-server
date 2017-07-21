class StoreService
  def initialize

  end

  def around(gps)
    Store.includes(:store_images).distance_from(gps).by_dist
  end
end
