class User < ApplicationRecord
  has_many :invitations, inverse_of: :user
  has_many :orders, inverse_of: :user
  has_many :user_devices, inverse_of: :user
  has_many :subscription_users, inverse_of: :user
  has_many :reviews, inverse_of: :user

  validates :email, presence: true, uniqueness: true
  validates :nickname, presence: true
  validates :recommendation_code, length: { maximum: 8 }, uniqueness: true, allow_nil: true
  validates :social_type, inclusion: { in: [1, 2] }, allow_nil: true

  has_secure_password

  before_create :gen_recommendation_code


  private
  def gen_recommendation_code
  	loop do
  		code = SecureRandom.hex(4)
  		self.recommendation_code = code
  		break if User.find_by(recommendation_code: code).nil?
  	end
  end
end
