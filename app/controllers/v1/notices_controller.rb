class V1::NoticesController < ::ApiController
  PER_PAGE = 20

  def index
    per_pg = params[:per] || PER_PAGE
    @notices = Notice.includes(:admin).page(params[:page]).per(per_pg)

    if @notices.present?
      meta = {
        limit_value: @notices.limit_value,
        total_pages: @notices.total_pages,
        current_page: @notices.current_page
      }
      render json: @notices, adapter: :json, meta: meta
    else
      head :no_content
    end
  end
end
