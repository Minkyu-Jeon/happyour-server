class V1::StoresController < ::ApiController
  def index
    require_params! :type

    case params[:type]
    when "gps"
      require_params! :gps

      data = StoreService.new.around(params[:gps])
    when "hash_tag"
      require_params! :tag_name

      data = StoreService.new.hash_tag(params[:tag_name])
    when "addr"
      require_params! :addr

      data = StoreService.new.addr(params[:addr])
    end

    render json: data, each_serializer: StoreSerializer
  end

  def show
    require_params! :gps

    store = Store.distance_from(params[:gps]).includes(:happyhours, menus: :menu_images).find(params[:id])

    render json: store, serializer: StoreShowSerializer, include: ["*"]
  end
end
