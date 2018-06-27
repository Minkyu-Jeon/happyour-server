class CreateQnas < ActiveRecord::Migration[5.0]
  def change
    create_table :qnas do |t|
      t.integer :user_id, limit: 4, null: false
      t.integer :admin_id, limit: 4
      t.string :title, limit: 255, null: false
      t.string :body, limit: 2000, null: false
      t.text :answer
      t.timestamp :answer_dttm
      t.timestamps
    end
  end
end
