class V1::OrdersController < ::ApiController
  def create
    require_params! :menu_id
    menu = Menu.find(params[:menu_id])

    order = Order.create!({
      menu_id: menu.id,
      user_id: current_user.id
    })

    render json: order, include: ["menu.menu_images"]
  end

  def update

  end
end
