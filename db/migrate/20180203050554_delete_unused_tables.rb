class DeleteUnusedTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :subscription_users
    drop_table :subscriptions
    drop_table :invitations
    drop_table :orders
  end
end
