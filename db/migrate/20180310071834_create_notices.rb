class CreateNotices < ActiveRecord::Migration[5.0]
  def change
    create_table :notices do |t|
      t.integer :admin_id, limit: 4, null: false
      t.string :title, limit: 255, null: false
      t.text :content
      t.timestamps

      t.index [:admin_id]
    end
  end
end
