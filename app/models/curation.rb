class Curation < ApplicationRecord
	has_many :curation_stores, inverse_of: :curation
	validates :title, presence: true
end
