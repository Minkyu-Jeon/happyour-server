class Order < ApplicationRecord
	belongs_to :user, inverse_of: :orders
	belongs_to :menu, inverse_of: :orders

	has_one :order_history, inverse_of: :order

  scope :today, -> { where("created_at > ?", Time.current.beginning_of_day) }

  before_create :validate_user_exp_dttm

  def is_expired?
    one_days_ago = 1.days.ago
    created_at < one_days_ago
  end

  def is_dup?
    self.class.today.where(user_id: self.user_id, is_receive: true).exists?
  end

  private
  def validate_user_exp_dttm
    exp_dttm = (self.user.subscription_exp_dttm || 1.day.ago)
    if Time.current < exp_dttm
      errors.add(:subscription_exp, "이용권 만료 혹은 없음")
    end
  end
end
