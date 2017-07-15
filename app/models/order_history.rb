class OrderHistory < ApplicationRecord
	belongs_to :order, inverse_of: :order_history

  mount_uploader :url, OrderHistoryUploader
end
