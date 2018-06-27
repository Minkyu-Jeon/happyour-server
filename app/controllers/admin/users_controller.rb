class Admin::UsersController < Admin::BaseController
  PER_PAGE = 20
	def index
		set_menu("users", "index")
    @users = User.all.page(params[:page]).per(PER_PAGE)
	end
end
