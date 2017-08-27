class Admin::UsersController < Admin::BaseController
	def index
		set_menu("users", "index")
	end
end
