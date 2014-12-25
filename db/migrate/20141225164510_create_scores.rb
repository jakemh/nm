class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :score
      t.string :scoreable_type
      t.integer :storeable_id
      t.integer :total_votes

      t.timestamps
    end
  end
end
