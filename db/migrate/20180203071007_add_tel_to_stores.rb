class AddTelToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :tel, :string, limit: 20
  end
end
