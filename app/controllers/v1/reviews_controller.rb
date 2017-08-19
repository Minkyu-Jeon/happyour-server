class V1::ReviewsController < ::ApiController
  def create
    require_params! :order_id, :evaluation, :eval_text

    ActiveRecord::Base.transaction do

      order = Order.find_by!(id: params[:order_id], is_receive: true)

      review = order.reviews.create!(review_params)

      render json: review
    end
  end

  private
  def review_params
    params.permit(:evaluation, :eval_text, :url)
  end
end
