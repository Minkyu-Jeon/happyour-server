class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :email, limit: 255, null: false
      t.string :password_digest, limit: 255, null: false
      t.string :name, limit: 100, null: false
      t.index [:email], unique: true
    end
  end
end
