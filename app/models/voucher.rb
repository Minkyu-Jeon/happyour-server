class Voucher < ApplicationRecord
  belongs_to :user, inverse_of: :vouchers

  scope :active, -> { where("expired_at > ?", Time.current) }
end
