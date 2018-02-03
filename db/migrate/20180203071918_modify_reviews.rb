class ModifyReviews < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :reviews, :menus
    remove_column :reviews, :menu_id

    add_column :reviews, :store_id, :integer, limit: 4, null: false
    add_index :reviews, :store_id
    add_foreign_key :reviews, :stores
  end
end
