class HappyhourSerializer < ApplicationSerializer
  attributes :day_of_week, :start_time, :end_time, :is_holiday

  belongs_to :store
end
