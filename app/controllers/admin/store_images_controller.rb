class Admin::StoreImagesController < Admin::BaseController
  def create
    image = StoreImage.new(image: params[:image])
    render json: { filename_cache: image.image_cache }
  end
end
