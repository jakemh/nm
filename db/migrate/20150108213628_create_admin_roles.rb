class CreateAdminRoles < ActiveRecord::Migration
  def change
    create_table :admin_roles do |t|
      t.integer :status

      t.timestamps
    end
  end
end
