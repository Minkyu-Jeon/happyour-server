class V1::QnasController < ::ApiController
  PER_PAGE = 20

  def index
    per_pg = params[:per] || PER_PAGE
    @qnas = current_user.qnas.
      includes(:admin).
      page(params[:page]).
      per(per_pg)

    if @qnas.present?
      meta = {
        limit_value: @qnas.limit_value,
        total_pages: @qnas.total_pages,
        current_page: @qnas.current_page
      }
      render json: @qnas, adapter: :json, meta: meta
    else
      head :no_content
    end
  end

  def create
    title = params.require(:title)
    body = params.require(:body)

    qna = current_user.qnas.build(title: title, body: body)

    qna.save or raise FailToSaveError.new(qna)

    render json: qna
  end
end
