class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
    	t.string :title, limit: 255, null: false
    	t.integer :type, limit: 1
      t.timestamps null: false
    end
  end
end
