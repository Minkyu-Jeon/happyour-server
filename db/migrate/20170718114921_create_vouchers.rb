class CreateVouchers < ActiveRecord::Migration[5.0]
  def change
    create_table :vouchers do |t|
      t.integer :user_id, limit: 4, null: false
      t.integer :invitation_user_id
      t.datetime :expired_at, null: false
      t.timestamps null: false

      t.index [:user_id]
      t.index [:invitation_user_id]
      t.index [:user_id, :expired_at]

      t.foreign_key :users
    end
  end
end
