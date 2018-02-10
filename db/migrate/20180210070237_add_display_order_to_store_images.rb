class AddDisplayOrderToStoreImages < ActiveRecord::Migration[5.0]
  def change
    add_column :store_images, :display_order, :integer, default: 0
  end
end
