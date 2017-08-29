class V1::OrdersController < ::ApiController
  def create
    require_params! :menu_id

    ActiveRecord::Base.transaction do
      menu = Menu.find(params[:menu_id])

      c_time = Time.current
      is_usable = menu.store.is_available_time?(c_time)
      raise ServiceError.new("현재는 Happyhour가 아닙니다.", :forbidden) unless is_usable

      order = Order.new({
        menu_id: menu.id,
        user_id: current_user.id
      })

      raise ServiceError.new("오늘은 더이상 주문 할 수 없습니다.", :conflict) if order.is_dup?

      order.save!

      head :ok
    end
  rescue ActiveRecord::RecordInvalid => e
    if e.record.errors.has_key?(:subscription_exp)
      head :payment_required
    else
      head :bad_request
    end
  end

  def update
    require_params! :is_receive

    order = Order.includes(menu: :store).find(params[:id])

    c_time = Time.current
    is_usable = order.menu.store.is_available_time?(c_time)
    raise ServiceError.new("현재는 Happyhour가 아닙니다.", :forbidden) unless is_usable

    raise ServiceError.new("만료된 주문건입니다.", :forbidden) if order.is_expired?

    raise ServiceError.new("이미 수령하셨습니다", :conflict) if order.is_receive

    order.update!(is_receive: params[:is_receive])

    render json: order
  end
end
