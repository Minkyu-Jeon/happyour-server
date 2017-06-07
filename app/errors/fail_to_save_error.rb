class FailToSaveError < ApplicationError
	attr_reader :record

	def initialize(record)
    if record.new_record?
      super("Failed to create. #{record.errors.inspect}")
    else
      super("Failed to update. #{record.errors.inspect}")
    end
		@record = record
	end
end
