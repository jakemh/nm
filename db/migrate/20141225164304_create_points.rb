class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :score
      t.integer :user_id
      t.integer :business_id
      t.string :pointable_type
      t.integer :pointable_id

      t.timestamps
    end
  end
end
