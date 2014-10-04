class AddBusinessIdColToConnection < ActiveRecord::Migration
  def change
    add_column :connections, :business_id, :integer
  end
end
