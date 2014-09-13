class RemoveFriendIdColumnFromConnection < ActiveRecord::Migration
  def change
    remove_column :connections, :friend_id, :integer
  end
end
