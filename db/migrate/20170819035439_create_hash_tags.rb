class CreateHashTags < ActiveRecord::Migration[5.0]
  def change
    create_table :hash_tags do |t|
      t.integer :store_id, limit: 4, null: false
      t.string :tag_name, limit: 255, null: false
      t.timestamps

      t.index [:tag_name]
      t.index [:store_id]
      t.foreign_key :stores
    end
  end
end
