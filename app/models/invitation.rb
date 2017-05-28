class Invitation < ApplicationRecord
	belongs_to :user, inverse_of: :invitations
end
