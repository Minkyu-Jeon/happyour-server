class Admin::MenuImagesController < Admin::BaseController
	def create
		image = MenuImage.new(image: params[:image])
    render json: { filename_cache: image.image_cache }
	end
end