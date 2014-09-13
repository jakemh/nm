class AddConnectToColumnToConnection < ActiveRecord::Migration
  def change
    add_column :connections, :connect_to_id, :integer
  end
end
