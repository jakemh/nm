class AddTypeColumnToConnection < ActiveRecord::Migration
  def change
    add_column :connections, :type, :string
  end
end
