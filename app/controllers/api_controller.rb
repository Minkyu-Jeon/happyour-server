class ApiController < ApplicationController
	rescue_from StandardError, with: :handle_error

	protected
	def require_params!(*args)
		args.each do |key|
			params.require(key.to_sym)
		end
	end

	private
	def handle_error(e)
		case e
		when ActionController::ParameterMissing
			head :bad_request
		when ActiveRecord::NotFound
			head :not_found
		end
	end
end