class AddProfilePhotoIdToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :profile_photo_id, :integer
  end
end
