class CreateReviewEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :review_evaluations do |t|
    	t.integer :user_id, limit: 4, null: false
    	t.integer :review_id, limit: 4, null: false
    	t.integer :evaluation, limit: 1, null: false

    	t.index [:user_id]
    	t.index [:review_id]
    	t.foreign_key :users
    	t.foreign_key :reviews
      t.timestamps
    end
  end
end
