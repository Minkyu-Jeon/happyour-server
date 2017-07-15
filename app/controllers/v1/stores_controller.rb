class V1::StoresController < ::ApiController
  def index
    data = Store.all
    render json: data
  end

  def show
  end
end
