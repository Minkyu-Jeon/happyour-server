class FranchiseImage < ActiveRecord::Base
	belongs_to :franchise, inverse_of: :franchise_images
end