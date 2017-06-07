class ServiceError < ApplicationError
  attr_reader :code, :errors

  def initialize(msg = nil, code = :internal_server_error, errors = [])
    super(msg)
    @code = code
    @errors = errors
  end
end
