class CreateUserDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :user_devices do |t|
      t.integer  :user_id,      limit: 4,   null: false
      t.string   :os_type
      t.string   :device_id
      t.string   :push_token
      t.string   :access_token, null: false
      t.timestamps null: false
      t.foreign_key :users
      t.index [:access_token]
      t.index [:user_id]
    end
  end
end
