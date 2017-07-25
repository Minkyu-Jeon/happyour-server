class DropTableVouchers < ActiveRecord::Migration[5.0]
  def change
  	drop_table :vouchers
  end
end
