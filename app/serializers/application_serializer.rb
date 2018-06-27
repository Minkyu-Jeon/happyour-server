class ApplicationSerializer < ActiveModel::Serializer
  def created_at
    I18n.l(object.created_at)
  end

  def updated_at
    I18n.l(object.updated_at)
  end
end
