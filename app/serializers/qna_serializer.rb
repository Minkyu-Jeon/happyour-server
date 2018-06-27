class QnaSerializer < ApplicationSerializer
  attributes :admin_name, :title, :body, :answer, :answer_dttm, :created_at, :updated_at

  def admin_name
    object.admin.try(:name)
  end

  def answer_dttm
    object.answer_dttm.present? ? I18n.l(object.answer_dttm) : nil
  end
end
