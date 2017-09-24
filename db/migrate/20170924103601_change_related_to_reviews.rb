class ChangeRelatedToReviews < ActiveRecord::Migration[5.0]
  def change
  	remove_foreign_key :reviews, :orders
  	remove_column :reviews, :order_id
  	add_column :reviews, :menu_id, :integer, limit: 4
  	add_index :reviews, [:menu_id]
  	add_foreign_key :reviews, :menus

  	add_column :reviews, :user_id, :integer, limit: 4
  	add_index :reviews, [:user_id]
  	add_foreign_key :reviews, :users
  end
end
