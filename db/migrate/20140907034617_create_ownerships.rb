class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer :user_id
      t.integer :business_id
      t.string :position

      t.timestamps
    end
  end
end
