class SubscriptionUser < ApplicationRecord
	belongs_to :subscription, inverse_of: :subscription_users
	belongs_to :user, inverse_of: :subscription_users

  before_create :extend_user_exp_dttm

  private
  def extend_user_exp_dttm
    user.update(subscription_exp_dttm: expired_at)
  end
end
