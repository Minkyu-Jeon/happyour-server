class Subscription < ApplicationRecord
	has_many :subscription_users, inverse_of: :subscription
end
