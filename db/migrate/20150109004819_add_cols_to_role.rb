class AddColsToRole < ActiveRecord::Migration
  def change
    add_column :roles, :roleable_id, :integer
    add_column :roles, :roleable_type, :string
  end
end
