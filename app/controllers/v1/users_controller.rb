class V1::UsersController < ::ApiController
	skip_before_action :authenticate_user_token!

	def social_login
		require_params! :social_type, :access_token
		user = SigninForSocial.new.call(params[:social_type], params[:access_token])
		user_device = UpdateDeviceInfo.new(user).call(happyour_header, params)
		render json: user_device, serializer: LoginSerializer
	end

	private
	def user_params
		params.permit(:email, :nickname, :password, :phone_number)
	end

	def social_params
		params.permit(:nickname, :social_type, :access_token, :phone_number)
	end
end
