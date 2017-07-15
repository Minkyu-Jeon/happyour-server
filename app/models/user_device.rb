class UserDevice < ApplicationRecord
  belongs_to :user, inverse_of: :user_devices
  validates :user, presence: true, uniqueness: true
  validates :access_token, presence: true, uniqueness: true

  def self.access_token
    begin
      access_token = SecureRandom.hex
    end while UserDevice.exists?(access_token: access_token)
    access_token
  end
end
