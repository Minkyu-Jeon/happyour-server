class V1::StoresController < ::ApiController
  def index
    require_params! :type

    case params[:type]
    when "gps"
      require_params! :gps

      data = StoreService.new.around(params[:gps])
    end

    render json: data
  end

  def show
    require_params! :gps

    store = Store.distance_from(params[:gps]).includes(:happyhours, menus: :menu_images).find(params[:id])

    render json: store, serializer: StoreShowSerializer, include: ["menus.menu_images", "store_images", "happyhours"]
  end
end
