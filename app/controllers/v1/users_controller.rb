class V1::UsersController < ApiController
	skip_before_action :authenticate_user_token!

	def create
		require_params! :email, :nickname, :password, :social_type

		user = User.find_or_initialize_by(email: params[:email])

		user.persisted? and raise ApplicationError.new(:conflict)

		user.set_user_default_auth_info

		user.save(user_params) or raise FailToSaveError.new(user)

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