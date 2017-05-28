class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
    	t.integer :franchise_id, null: false, index: true
    	t.string :name, null: false
    	t.integer :price
      t.timestamps
      t.foreign_key :franchises
    end

    create_table :menu_images do |t|
    	t.integer :menu_id, null: false, index: true
    	t.string :url
    	t.foreign_key :menus
    end
  end
end
