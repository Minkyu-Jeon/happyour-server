class RenameFranchise < ActiveRecord::Migration[5.0]
  def change
    rename_column :franchise_image, :franchise_id, :store_id
    rename_column :menus, :franchise_id, :store_id

    rename_table :franchises, :stores
    rename_table :franchise_image, :store_images
  end
end
