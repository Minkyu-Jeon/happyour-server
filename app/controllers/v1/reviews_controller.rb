class V1::ReviewsController < ::ApiController
  before_action :authenticate_user_token!, only: [:create, :evaluate]
  PER_PAGE = 15
  def index
    require_params! :current_dttm
    @reviews = Store.find(params[:store_id]).reviews
    total_count = @reviews.count
    page = params[:page] || 0

    # 일단 최신순
    @reviews = @reviews.
      where("reviews.created_at < ?", params[:current_dttm]).
      includes(:user, :review_evaluations).
      limit(PER_PAGE).
      offset(PER_PAGE * page)

    render json: @reviews, adapter: :json, root: :reviews, meta: { per_page: PER_PAGE, total_count: total_count }
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
