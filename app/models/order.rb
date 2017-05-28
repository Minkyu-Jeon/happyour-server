class Order < ApplicationRecord
	belongs_to :user, inverse_of: :orders
	belongs_to :menu, inverse_of: :orders

	has_one :order_history, inverse_of: :order
end
