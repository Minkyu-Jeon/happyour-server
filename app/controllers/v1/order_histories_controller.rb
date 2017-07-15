class V1::OrderHistoriesController < ::ApiController
  def create
    require_params! :order_id, :evaluation, :eval_text

    order = Order.find_by!(id: params[:order_id], is_receive: true)

    history = order.order_history || order.build_order_history

    history.update!({evaluation: params[:evaluation], eval_text: params[:eval_text], url: params[:url]})

    render json: history
  end
end
