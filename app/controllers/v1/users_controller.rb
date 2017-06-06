class V1::UsersController < ApiController
	skip_before_action :authenticate_user_token!

	def create
		require_params! :email, :nickname, :password, :social_type
		head :ok
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
end