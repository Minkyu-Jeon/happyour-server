class ReviseReviews < ActiveRecord::Migration[5.0]
  def change
  	remove_column :reviews, :evaluation, :integer, limit: 1
  end
end
