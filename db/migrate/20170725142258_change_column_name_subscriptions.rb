class ChangeColumnNameSubscriptions < ActiveRecord::Migration[5.0]
  def change
  	rename_column :subscriptions, :type, :subscription_type
  	add_column :subscriptions, :days, :integer, limit: 4, null: false
  end
end
