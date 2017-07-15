class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string   :email, null: false
      t.string   :nickname
      t.string   :recommendation_code
      t.integer  :social_type, limit: 1
      t.string   :password_digest, null: false
      t.string   :phone_number, limit: 15
      t.timestamps null: false

      t.index [:email], unique: true
      t.index [:recommendation_code]
      t.index [:phone_number]
      t.index [:nickname]
    end
  end
end
