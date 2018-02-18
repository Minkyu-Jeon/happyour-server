class AddDisplayOrderToMenuImage < ActiveRecord::Migration[5.0]
  def change
  	add_column :menu_images, :display_order, :integer, limit: 4, default: 0
  end
end
