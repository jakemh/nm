class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :reviewable_type
      t.integer :reviewable_id
      t.text :subject
      t.text :body
      t.integer :score

      t.timestamps
    end
  end
end
