class V1::StoresController < ::ApiController
  def index
    require_params! :gps
    require_store_params!

    @stores = StoreService.call(params)
    meta = { store_count: @stores[:total_count] }
    meta.merge!(current_page: params[:page]) if params[:page].present?
    render json: @stores[:records], adapter: :json, root: :stores, meta: meta
  end

  def show
    require_params! :gps

    store = Store.distance_from(params[:gps]).includes(:happyhours, menus: :menu_images).find(params[:id])

    render json: store, serializer: StoreShowSerializer, include: ["*", "menus.*"]
  end

  private
  def require_store_params!
    !(params[:time].present? ^ params[:page].present?) or raise BlankParameterError.new
  end
end
