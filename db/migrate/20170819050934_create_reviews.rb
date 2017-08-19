class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :order_id, limit: 4, null: false
      t.integer :evaluation, limit: 1
      t.text    :eval_text,  limit: 65535
      t.string  :url
      t.timestamps

      t.index [:order_id]
      t.foreign_key :orders
    end
  end
end
