class Admin::CurationsController < Admin::BaseController
	before_action :set_menu

	def index
		@curations = Curation.all.includes(curation_stores: :store)
	end

	def new
		@curation = Curation.new
		@store_ids = @curation.curation_stores.map(&:store_id)
	end

	def create
		@curation = Curation.new(curation_params)
		if @curation.save
			redirect_to curations_path
		else
			render :new
		end
	end

	def edit
		@curation = Curation.find(params[:id])
		@store_ids = @curation.curation_stores.map(&:store_id)
	end

	def update
		@curation = Curation.find(params[:id])
		attrs = { title: params[:curation][:title] }
		curation_stores = @curation.curation_stores
		if params[:curation][:curation_stores_attributes].present?
			curation_store_ids = curation_stores.map(&:store_id)
			new_store_ids = params[:curation][:curation_stores_attributes].map { |value| value[:store_id].to_i }
			add_item = (new_store_ids - curation_store_ids).map{|i| {store_id: i} }
			delete_item = curation_store_ids - new_store_ids
			curation_stores = curation_stores.where(curation_stores: {store_id: delete_item})
			attrs[:curation_stores_attributes] = add_item
		end
		curation_stores.destroy_all

		if @curation.update(attrs)
			redirect_to curations_path
		else
			render :edit
		end
	end

	private
	def set_menu
		super("curations", params[:action])
	end
	def curation_params
		params.require(:curation).permit(:title, curation_stores_attributes: [:store_id])
	end
end