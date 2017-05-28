class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
    	t.integer :user_id, limit: 4, index: true, null: false
    	t.string :email
    	t.integer :invited_user_id, index: true
      t.timestamps

      t.foreign_key :users
    end

  end
end
