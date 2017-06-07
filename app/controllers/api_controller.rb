class ApiController < ApplicationController
	before_action :authenticate_user_token!
	rescue_from StandardError, with: :handle_error

	attr_reader :current_user

	protected
	def require_params!(*args)
		args.each do |p|
			val = params[p]
			blank = val.is_a?(Array) ? val.any?(&:blank?) : val.blank?
			blank and raise BlankParameterError.new(p)
		end
	end

	def authenticate_user_token!
		authenticate_user_token
		raise ServiceError.new("사용자 인증 실패", :unauthorized) unless current_user.present?
	end

	def authenticate_user_token
		authenticate_or_request_with_http_token do |token, option|
			@current_user = User.find_by_user_token(token)
		end
	end

	def log_error(e)
	  logger.error { ["#{e.class.to_s} (#{e.message})"].concat(Rails.backtrace_cleaner.clean(e.backtrace)).join("\n  ") }
	end

	def handle_error(e)
		log_error(e)

		case e
		when FailToSaveError
			if e.record.errors.present?
				head :bad_request
			else
				head :internal_server_error
			end
		when ServiceError
			head e.code
		when BlankParameterError, ActionController::ParameterMissing
			head :bad_request
		when ActiveRecord::RecordNotFound
			head :not_found
		end
	end
end
