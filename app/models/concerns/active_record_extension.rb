module ActiveRecordExtension
	extend ActiveSupport::Concern

	class_methods do
		def human_attributes_value(attr, val)
			if val.present? || val.is_a?(FalseClass)
				key = "activerecord.values.#{self.model_name.name.underscore}.#{attr}.#{val}"
				if I18n.exists?(key)
					I18n.t(key)
				else
					val
				end
			else
				val
			end
			
		end
	end

	def translate(attr)
		self.class.human_attributes_value(attr, public_send(attr))
	end
end