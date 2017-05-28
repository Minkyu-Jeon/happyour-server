class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :invitations, inverse_of: :user
  has_many :orders, inverse_of: :user
end
