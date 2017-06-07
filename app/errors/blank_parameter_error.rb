class BlankParameterError < ApplicationError
  def initialize(p)
    super("'#{p}' is blank")
  end
end
