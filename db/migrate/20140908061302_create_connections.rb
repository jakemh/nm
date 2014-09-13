class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :business_id
      t.string :relationship

      t.timestamps
    end
  end
end
