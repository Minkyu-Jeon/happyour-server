class CreateCurations < ActiveRecord::Migration[5.0]
  def change
    create_table :curations do |t|
    	t.string :title, limit: 255, null: false
    	t.boolean :is_published, default: false
      t.timestamps
    end
  end
end
