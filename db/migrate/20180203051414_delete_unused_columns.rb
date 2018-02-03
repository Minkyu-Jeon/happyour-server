class DeleteUnusedColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :recommendation_code
    remove_column :users, :subscription_exp_dttm

    remove_column :stores, :code
  end
end
