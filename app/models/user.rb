class User < ApplicationRecord
  has_many :user_devices, inverse_of: :user
  has_many :reviews, inverse_of: :user

  validates :loginid, presence: true, uniqueness: true
  validates :nickname, presence: true
  validates :social_type, inclusion: { in: [1, 2] }, allow_nil: true

  has_secure_password
end
