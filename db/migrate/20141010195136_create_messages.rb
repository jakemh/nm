class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :business_id
      t.text :subject
      t.text :content
      # t.integer :to_id
      # t.string :to_entity
      t.timestamps
    end
  end
end
