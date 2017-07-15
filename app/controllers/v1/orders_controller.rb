class V1::OrdersController < ::ApiController
  def create
    require_params! :menu_id

    ActiveRecord::Base.transaction do
      menu = Menu.find(params[:menu_id])

      order = Order.new({
        menu_id: menu.id,
        user_id: current_user.id
      })

      raise ServiceError.new("오늘은 더이상 주문 할 수 없습니다.", :conflict) if order.is_dup?

      order.save!

      render json: order, include: ["menu.menu_images"]
    end
  end

  def update
    require_params! :is_receive

    order = Order.find(params[:id])

    raise ServiceError.new("만료된 주문건입니다.", :forbidden) if order.is_expired?

    raise ServiceError.new("이미 수령하셨습니다", :conflict) if order.is_receive

    order.update!(is_receive: params[:is_receive])

    render json: order, include: ["menu.menu_images"]
  end
end
