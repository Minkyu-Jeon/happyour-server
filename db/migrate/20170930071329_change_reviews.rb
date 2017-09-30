class ChangeReviews < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :url, :string

    create_table :review_images do |t|
      t.integer :review_id, limit: 4, null: false
      t.string :url, null: false
      t.timestamp null: false
      t.index [:review_id]
      t.foreign_key :reviews
    end
  end
end
