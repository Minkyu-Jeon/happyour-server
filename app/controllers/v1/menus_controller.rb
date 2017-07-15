class V1::MenusController < ::ApiController
  def show
    menu = Menu.find(params[:id])

    render json: menu
  end
end
