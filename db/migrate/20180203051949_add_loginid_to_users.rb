class AddLoginidToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, :email
    add_index :users, :email

    change_column :users, :email, :string, null: true
    add_column :users, :loginid, :string, limit: 255, null: false

    add_index :users, :loginid, unique: true
  end
end
