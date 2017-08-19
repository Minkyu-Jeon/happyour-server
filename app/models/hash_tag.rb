class HashTag < ApplicationRecord
  belongs_to :store, inverse_of: :hash_tags

  validates :store_id, :tag_name, presence: true
end
