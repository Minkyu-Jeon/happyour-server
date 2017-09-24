class V1::ReviewsController < ::ApiController
  def create
    require_params! :menu_id, :evaluation, :eval_text

    ActiveRecord::Base.transaction do

      menu = Menu.find_by!(id: params[:menu_id])

      review = menu.reviews.create!(review_params)

      render json: review
    end
  end

  private
  def review_params
    params.permit(:evaluation, :eval_text, :url)
  end
end
