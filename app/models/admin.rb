class Admin < ApplicationRecord
  validates :email, :name, presence: true

  has_secure_password
end
