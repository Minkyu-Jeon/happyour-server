class StoreService
  def around(gps)
    Store.includes(:store_images).distance_from(gps).by_dist
  end

  def hash_tag(tag_name)
    Store.joins(:hash_tags).where("hash_tags.tag_name LIKE ?", "%#{tag_name}%")
  end

  def addr(addr)
    Store.where("address LIKE ?", "%#{addr}%")
  end
end
