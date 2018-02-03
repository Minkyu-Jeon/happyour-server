class StoreService
  class << self

    def call(params)
      result = {}

      scope = Store.distance_from(params[:gps]).includes(:hash_tags, :store_images)

      if params[:time].present?
        subquery = Happyhour.select(:store_id).where("start_time <= :time AND end_time >= :time", {time: params[:time]})
          .group(:store_id)
        scope = scope.where("stores.id IN (#{subquery.to_sql})")
      end

      result = { records: scope, total_count: scope.size }

      if params[:page].present?
        offset = page_limit * (params[:page].to_i - 1)
        result[:records] = scope.limit(page_limit).offset(offset)
      end

      result
    end

    private
    def page_limit
      @@page_limit ||= 20
    end
  end
end
