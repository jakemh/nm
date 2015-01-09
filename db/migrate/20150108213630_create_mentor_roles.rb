class CreateMentorRoles < ActiveRecord::Migration
  def change
    create_table :mentor_roles do |t|
      t.integer :category

      t.timestamps
    end
  end
end
