class SubscriptionUser < ApplicationRecord
	belongs_to :subscription, inverse_of: :subscription_users
	belongs_to :user, inverse_of: :subscription_users
end
