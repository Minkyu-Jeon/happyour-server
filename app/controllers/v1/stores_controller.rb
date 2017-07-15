class V1::StoresController < ::ApiController
  def index
    require_params! :type

    case params[:type]
    when "around_me", "map"
      require_params! :gps

      data = StoreService.new.around(params[:gps])
    end

    render json: data
  end

  def show
  end
end
