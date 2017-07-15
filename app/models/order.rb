class Order < ApplicationRecord
	belongs_to :user, inverse_of: :orders
	belongs_to :menu, inverse_of: :orders

	has_one :order_history, inverse_of: :order

  scope :today, -> { where("created_at > ?", Time.current.beginning_of_day) }

  def is_expired?
    one_days_ago = 1.days.ago
    created_at < one_days_ago
  end

  def is_dup?
    self.class.today.where(user_id: self.user_id, is_receive: true).exists?
  end
end
