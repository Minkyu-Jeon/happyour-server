class ApiController < ApplicationController
	rescue_from StandardError, with: :handle_error

	before_action :authenticate_user_token!
	attr_reader :current_user, :current_device

	protected
	def require_params!(*args)
		args.each do |p|
			val = params[p]
			blank = val.is_a?(Array) ? val.any?(&:blank?) : val.blank?
			blank and raise BlankParameterError.new(p)
		end
	end

	def happyour_header
		@happyour_header ||= {
			os_type: request.headers["X-Happyour-OS-Type"],
			os_version: request.headers["X-Happyour-OS-Version"],
			version: request.headers["X-Happyour-Version"],
			device_id: request.headers["X-Happyour-Device-Id"]
		}.freeze
	end

	def authenticate_user_token!
		authenticate_user_token
		raise UnauthorizedError.new if current_user.blank?
	end

	def authenticate_user_token
		authenticate_or_request_with_http_token do |token, option|
			@current_device = UserDevice.find_by_access_token(token)
			@current_user = current_device.try(:user)
		end
	end

	def log_error(e)
	  logger.error { ["#{e.class.to_s} (#{e.message})"].concat(Rails.backtrace_cleaner.clean(e.backtrace)).join("\n  ") }
	end

	def handle_error(e)
		log_error(e)

		case e
		when UnauthorizedError
			head :unauthorized
		when FailToSaveError
			if e.record.errors.present?
				head :bad_request
			else
				head :internal_server_error
			end
		when ServiceError
			head e.code
		when BlankParameterError, ActionController::ParameterMissing, SocialProfileError
			head :bad_request
		when ActiveRecord::RecordNotFound
			head :not_found
		else
			head :internal_server_error
		end
	end
end
