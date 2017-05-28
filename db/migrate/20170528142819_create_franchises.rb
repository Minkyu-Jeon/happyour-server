class CreateFranchises < ActiveRecord::Migration[5.0]
  def change
    create_table :franchises do |t|
    	t.string :name, null: false
    	t.string :address, limit: 1000, null: false
    	t.string :description, limit: 1000
    	t.string :code, limit: 10
    	t.string :open_time, limit: 8
    	t.string :close_time, limit: 8
    	t.string :gps

      t.timestamps null: false

      t.index [:code]
    end

    create_table :franchise_image do |t|
    	t.integer :franchise_id, index: true
    	t.string :url

    	t.foreign_key :franchises
    end
  end
end
