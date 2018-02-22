class CurationStore < ApplicationRecord
	belongs_to :curation, inverse_of: :curation_stores
	belongs_to :store, inverse_of: :curation_stores
end
