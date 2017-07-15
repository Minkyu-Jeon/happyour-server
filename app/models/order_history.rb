class OrderHistory < ApplicationRecord
	belongs_to :order, inverse_of: :order_history
end
