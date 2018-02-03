class V1::ReviewsController < ::ApiController
  before_action :authenticate_user_token!

  def create
    require_params! :menu_id, :evaluation, :eval_text

    ActiveRecord::Base.transaction do
      menu = Menu.find_by!(id: params[:menu_id])

      review = menu.reviews.create!(review_params.merge(user: current_user))

      review.review_images.each { |img| i.destroy }

      if params[:review_images].present?
        params[:review_images].each do |img|
          review.review_images.create!({
            url: img
          })
        end
      end

      render json: review
    end
  end

  private
  def review_params
    params.permit(:menu_id, :evaluation, :eval_text, :review_images)
  end
end
