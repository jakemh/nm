class AddVeteranColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_veteran, :boolean
  end
end
