class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :invitations, inverse_of: :user
  has_many :orders, inverse_of: :user

  validates :email, absence: true, uniqueness: true
  validates :nickname, presence: true, uniqueness: true
  validates :recommendation_code, length: { maximum: 10 }, uniqueness: true
  validates :social_type, inclusion: { in: [1, 2] }, allow_nil: true

  before_create :gen_recommendation_code

  def set_user_default_auth_info
    gen_user_token
    gen_user_secret
  end

  private
  def gen_recommendation_code
  	loop do
  		code = SecureRandom.hex(10)
  		self.recommendation_code = code
  		break if User.find_by(recommendation_code: code).nil?
  	end
  end

  def gen_user_token
    loop do
      code = SecureRandom.hex(128)
      self.user_token = code
      break if User.find_by(user_token: code).nil?
    end
  end

  def gen_user_secret
    loop do
      code = SecureRandom.hex(128)
      self.user_secret = code
      break if User.find_by(user_secret: code).nil?
    end
  end
end
