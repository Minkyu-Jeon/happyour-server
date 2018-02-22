class Admin::HappyhoursController < Admin::BaseController
	def bulk_edit
		@store = Store.find(params[:store_id])
		@happyhours = @store.happyhours.where(day_of_week: params[:day_of_week])
		html = render_to_string layout: false, format: :html
		render json: {html: html}
	end
	def bulk_update
		@store = Store.find(params[:store_id])
		if params[:happyhour].present?
			ActiveRecord::Base.transaction do
				destroy_items = []
				params[:happyhour].each do |hh|
					if hh[:_destroy] == "1" && hh[:id].present?
						destroy_items << hh[:id]
						next
					end
					permitted_params = hh.permit(:start_time, :end_time, :day_of_week)
					if hh[:id].blank?
						next if hh[:_destroy] == "1"
						@store.happyhours.create!(permitted_params)
					else
						@store.happyhours.find(hh[:id]).update!(permitted_params)
					end
				end
				@store.happyhours.where(happyhours: { id: destroy_items, day_of_week: params[:day_of_week] }).destroy_all if destroy_items.present?
			end
			html = render_to_string partial: 'td', locals: { happyhours: @store.happyhours.where(happyhours: { day_of_week: params[:day_of_week] }) }
			render json: { html: html }
		else
			render json: { html: "" }
		end
	end
	def set_holiday
		@store = Store.find(params[:store_id])
		scope = @store.happyhours.where({happyhours: { day_of_week: params[:day_of_week] }})
		scope.where.not(happyhours: { is_holiday: true }).destroy_all
		result = true
		result = @store.happyhours.create!(is_holiday: true, day_of_week: params[:day_of_week]) unless scope.present?
		render json: { result: result }
	end

end