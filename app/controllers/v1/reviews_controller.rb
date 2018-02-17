class V1::ReviewsController < ::ApiController
  before_action :authenticate_user_token!, only: [:create]

  def index
    require_params! :current_dttm
    @reviews = Store.find(params[:store_id]).
      reviews.
      where("reviews.created_at > ?", params[:current_dttm]).
      includes(:user, :review_evaluations) # 일단 최신순

    render json: @reviews, adapter: :json, root: :reviews
  end

  def create
    require_params! :eval_text
    store = Store.find(params[:store_id])
    review = store.reviews.create!(review_params.merge(user: current_user))
    render json: review    
  end

  private
  def review_params
    params.permit(:eval_text)
  end
end
