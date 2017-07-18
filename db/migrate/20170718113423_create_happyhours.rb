class CreateHappyhours < ActiveRecord::Migration[5.0]
  def change
    create_table :happyhours do |t|
      t.integer :store_id, limit: 4, null: false
      t.integer :day_of_week, limit: 1, null: false
      t.string :start_time, limit: 8
      t.string :end_time, limit: 8
      t.boolean :is_holiday, default: false
      t.timestamps

      t.index [:store_id]
      t.index [:day_of_week]

      t.foreign_key :stores
    end
  end
end
