class Admin::SessionsController < Admin::BaseController
  def new

  end

  def create

  end

  def destory
    reset_session
    redirect_to root_path
  end
end
