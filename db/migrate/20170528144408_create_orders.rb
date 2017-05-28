class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
    	t.integer :user_id, null: false, index: true
    	t.integer :menu_id, null: false, index: true
      t.timestamps

      t.foreign_key :users
      t.foreign_key :menus
    end

    create_table :order_histories do |t|
    	t.integer :order_id, null: false, index: true
    	t.integer :evaluation, limit: 1
    	t.text :eval_text
    	t.string :url

    	t.foreign_key :orders
    end
  end
end
