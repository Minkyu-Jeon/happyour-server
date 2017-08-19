class AddDiscountPriceToMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :discounted_price, :integer, length: 4
  end
end
