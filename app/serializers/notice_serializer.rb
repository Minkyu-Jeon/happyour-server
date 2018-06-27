class NoticeSerializer < ApplicationSerializer
  attributes :admin_name, :content, :created_at, :updated_at

  def admin_name
    object.admin.name
  end
end
