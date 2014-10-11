class CreateMessageRecipients < ActiveRecord::Migration
  def change
    create_table :message_recipients do |t|
      t.integer :message_id
      t.integer :user_id
      t.integer :business_id

      t.timestamps
    end
  end
end
