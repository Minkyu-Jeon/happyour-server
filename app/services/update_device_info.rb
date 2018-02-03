class UpdateDeviceInfo
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call(happyour_header, params={})
    user_device = user.user_device

    if user_device.nil?
      device_attrs = happyour_header.slice(:os_type, :device_id).merge({
        push_token: params[:push_token],
        access_token: UserDevice.access_token
      })
      user_device = user.build_user_device(device_attrs)
      user_device.save!
    else
      user_device.update!(access_token: UserDevice.access_token)
    end
    user_device
  end
end
