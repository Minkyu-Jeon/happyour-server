class V1::UsersController < ::ApiController
	skip_before_action :authenticate_user_token!

	def social_signup
		result = SignupForSocial.new(social_params).call

		head result.data
	end

	def social_login
		require_params! :social_type, :access_token

		user = SigninForSocial.new.call(params[:social_type], params[:access_token])

		user.present? or raise ServiceError.new("가입된 이메일이 없습니다.", :not_found)

		user_device = user.user_devices.last

		if user_device.nil?

			device_attrs = happyout_header.slice(:os_type, :device_id).merge({
				push_token: params[:push_token],
				access_token: UserDevice.access_token
			})

			user_device = user.user_devices.build(device_attrs)

			user_device.save!
		else
			user_device.update!(access_token: UserDevice.access_token)
		end

		render json: user_device, serializer: LoginSerializer
	end

	private
	def user_params
		params.permit(:email, :nickname, :password, :phone_number)
	end

	def social_params
		params.permit(:nickname, :social_type, :access_token, :phone_number, :recommendation_code)
	end
end
