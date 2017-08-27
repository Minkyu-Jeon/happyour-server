class Admin::StoresController < Admin::BaseController
	def index
		set_menu("stores", "index")
		@stores = Store.all
	end
end
