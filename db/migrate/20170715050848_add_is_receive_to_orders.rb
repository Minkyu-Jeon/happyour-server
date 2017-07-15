class AddIsReceiveToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :is_receive, :boolean, default: false

    add_index :orders, :is_receive
    add_index :orders, [:user_id, :is_receive]
  end
end
