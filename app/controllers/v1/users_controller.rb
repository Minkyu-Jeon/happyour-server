class V1::UsersController < ::ApiController
	skip_before_action :authenticate_user_token!

	def create
		require_params! :email, :nickname, :password

		user = User.find_or_initialize_by(email: params[:email])

		user.persisted? and raise ServiceError.new("이메일 중복", :conflict)

		user.set_auth_data

		user.attributes = user_params

		user.save or raise FailToSaveError.new(user)

		render json: user
	end

	def social_signup
		head :ok
	end

	def login
		head :ok
	end

	def social_login
		head :ok
	end

	private
	def user_params
		params.permit(:email, :nickname, :password, :social_type)
	end
end
