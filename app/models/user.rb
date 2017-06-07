class User < ApplicationRecord
  has_many :invitations, inverse_of: :user
  has_many :orders, inverse_of: :user

  validates :email, absence: true, uniqueness: true
  validates :nickname, presence: true, uniqueness: true
  validates :recommendation_code, length: { maximum: 10 }, uniqueness: true
  validates :social_type, inclusion: { in: [1, 2] }, allow_nil: true

  has_secure_password

  before_create :gen_recommendation_code

  def set_auth_data
    begin
      self.user_token = SecureRandom.hex
    end while self.class.unscoped.exists?(user_token: user_token)
    begin
      self.user_secret = SecureRandom.hex
    end while self.class.unscoped.exists?(user_secret: user_secret)
  end

  private
  def gen_recommendation_code
  	loop do
  		code = SecureRandom.hex(10)
  		self.recommendation_code = code
  		break if User.find_by(recommendation_code: code).nil?
  	end
  end
end
