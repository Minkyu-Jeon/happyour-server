class Admin < ApplicationRecord
  validates :email, :name, presence: true
  has_many :notices

  has_secure_password
end
