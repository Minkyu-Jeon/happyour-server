class V1::UsersController < ::ApiController
	skip_before_action :authenticate_user_token!

	def create
		require_params! :email, :nickname, :password

		user = User.find_or_initialize_by(email: params[:email])

		user.persisted? and raise ServiceError.new("이메일 중복", :conflict)

		user.attributes = user_params

		user.save or raise FailToSaveError.new(user)

		render json: user
	end

	def social_signup
		result = SignupForSocial.new(social_params).call

		head result.data
	end

	def login
		require_params! :email, :password

		user = User.find_by!(email: params.delete(:email))

		user.authenticate(params.delete(:password)) or raise ServiceError.new("비밀번호 오류", :unauthorized)

		user_device = user.user_devices.last

		if user_device.nil?

			device_attrs = happyout_header.slice(:os_type, :device_id).merge({
				push_token: params[:push_token],
				access_token: UserDevice.access_token
			})

			device = user.user_devices.build(device_attrs)

			device.save!
		end

		render json: device, serializer: LoginSerializer
	end

	def social_login
		head :ok
	end

	private
	def user_params
		params.permit(:email, :nickname, :password, :social_type, :phone_number)
	end

	def social_params
		params.permit(:nickname, :social_type, :access_token, :phone_number)
	end
end
