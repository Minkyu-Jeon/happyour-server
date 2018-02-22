class CreateCurationStores < ActiveRecord::Migration[5.0]
  def change
    create_table :curation_stores do |t|
    	t.integer :curation_id, limit: 4, null: false
    	t.integer :store_id, limit: 4, null: false
    	t.integer :display_order, default: 0, index: true
      t.timestamps

      t.index [:curation_id]
      t.index [:store_id]
      t.foreign_key :curations
      t.foreign_key :stores
    end
  end
end
