class Admin::MenusController < Admin::BaseController
	def edit
		@store = Store.find(params[:store_id])
		@menu = @store.menus.includes(:menu_images).find(params[:id])
	end

	def update
		@store = Store.find(params[:store_id])
		@menu = @store.menus.includes(:menu_images).find(params[:id])
		if @menu.update(menu_params)
      redirect_to store_path(@store)
    else
      render :edit
    end
	end

	private
	def menu_params
		params.require(:menu).permit(:name, :price, :discounted_price, menu_images_attributes: [:id, :_destroy, :display_order, :image_cache])
	end
end
