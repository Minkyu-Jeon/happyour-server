class Admin::SessionsController < Admin::BaseController
  skip_before_action :authenticate_admin!
  layout 'admin/session'

  def new
  end

  def create
    admin = Admin.find_by(email: params[:email])
    unless admin.try(:authenticate, params[:password])
      redirect_to login_path, flash: { message: t("authenticate.invalid") }
      return
    end
    session[:current_admin_id] = admin.id
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
