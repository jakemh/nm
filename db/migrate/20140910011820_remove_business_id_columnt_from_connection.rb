class RemoveBusinessIdColumntFromConnection < ActiveRecord::Migration
  def change
    remove_column :connections, :business_id, :integer
  end
end
