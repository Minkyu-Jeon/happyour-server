class AddPromotionTagToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :promotion_tag, :string, limit: 255
  end
end
