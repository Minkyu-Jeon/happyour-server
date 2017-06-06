class AddColumnsRelatedToUserAuthentication < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :user_token, :string
  	add_column :users, :user_secret, :string
  end
end
