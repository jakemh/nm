class CreateMessagePolies < ActiveRecord::Migration
  def change
    create_table :message_polies do |t|
      t.integer :user_id
      t.integer :business_id
      t.text :subject
      t.text :content
      # t.integer :messageable_id
      # t.string :messageable_type

      t.timestamps
    end
  end
end
