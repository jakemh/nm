class AddCoverPhotoIdColToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :cover_photo_id, :integer
  end
end
