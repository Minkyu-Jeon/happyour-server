class Curation < ApplicationRecord
	has_many :curation_stores, inverse_of: :curation
	validates :title, presence: true

	accepts_nested_attributes_for :curation_stores, allow_destroy: true
end
