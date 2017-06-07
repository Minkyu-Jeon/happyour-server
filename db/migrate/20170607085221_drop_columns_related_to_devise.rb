class DropColumnsRelatedToDevise < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    remove_column :users, :failed_attempts

    add_column :users, :password_digest, :string, null: false, default: ""
    add_column :users, :phone_number, :string, limit: 15, index: true

    add_index :users, [:user_secret]
  end
end
