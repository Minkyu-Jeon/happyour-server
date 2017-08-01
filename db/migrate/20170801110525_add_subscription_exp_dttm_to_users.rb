class AddSubscriptionExpDttmToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscription_exp_dttm, :datetime
    add_index :users, [:subscription_exp_dttm]
  end
end
