class OrderHistory < ActiveRecord::Base
	belongs_to :order, inverse_of: :order_history
end