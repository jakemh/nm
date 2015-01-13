class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.integer :awardable_id
      t.string :awardable_type

      t.timestamps
    end
  end
end
