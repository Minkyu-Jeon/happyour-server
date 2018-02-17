class User < ApplicationRecord
  has_one :user_device, inverse_of: :user
  has_many :reviews, inverse_of: :user
  has_many :review_evaluations, inverse_of: :user

  validates :loginid, presence: true, uniqueness: true
  validates :social_type, inclusion: { in: [1, 2] }, allow_nil: true

  has_secure_password
end
