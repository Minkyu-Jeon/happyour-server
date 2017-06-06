class ApiController < ApplicationController
	rescue_from StandardError, with: :handle_error
	before_action :authenticate_user_token!

	attr_reader :current_user

	protected
	def require_params!(*args)
		args.each do |key|
			params.require(key.to_sym)
		end
	end

	def authenticate_user_token!
		authenticate_or_request_with_http_token do |token, option|
			@current_user = User.find_by_user_token(token)
			@current_user.present? or raise ApplicationError.new(:unauthorized)
		end
	end

	private
	def handle_error(e)
		case e
		when FailToSaveErrror
			head :internal_server_error
		when ApplicationError
			head e.code
		when ActionController::ParameterMissing
			head :bad_request
		when ActiveRecord::NotFound
			head :not_found
		end
	end
end