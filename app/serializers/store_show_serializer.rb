class StoreShowSerializer < StoreSerializer
  has_many :menus
  has_many :happyhours
end
