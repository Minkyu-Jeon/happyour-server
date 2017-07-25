class CreateSubscriptionUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :subscription_users do |t|
    	t.integer :user_id, limit: 4, null: false
    	t.integer :subscription_id, limit: 4, null: false
    	t.datetime :expired_at, null: false
    	t.integer :invitation_id, limit: 4
      t.timestamps null: false

      t.index [:user_id]
      t.index [:subscription_id]
      t.index [:expired_at]
      t.index [:invitation_id]
      
      t.foreign_key :users
      t.foreign_key :subscriptions
    end
  end
end
