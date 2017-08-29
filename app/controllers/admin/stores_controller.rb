class Admin::StoresController < Admin::BaseController
  before_action :find_store, only: [:edit]
	def index
		set_menu("stores", "index")
		@stores = Store.all
	end

  def edit
    set_menu("stores", "edit")
  end

  private
  def find_store
    @store = Store.find(params[:id])
  end
end
