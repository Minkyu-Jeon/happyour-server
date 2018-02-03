class V1::UsersController < ::ApiController
	def social_signup
		require_params! :access_token, :social_type, :nickname
		result = SignupForSocial.new(social_params).call
		render json: result, serializer: LoginSerializer
	end

	def social_login
		require_params! :social_type, :access_token
		user = SigninForSocial.new.call(params[:social_type], params[:access_token])
		user.present? or raise ServiceError.new("가입된 이메일이 없습니다.", :not_found)
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
