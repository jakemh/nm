module Entity
  extend ActiveSupport::Concern
  included do
    has_many :flags, :as => :flaggable
    has_many :photos, :as => :imageable, :dependent => :destroy
  end

 def profile_photo
   if self.profile_photo_id
     self.profile_photos.find self.profile_photo_id
   end
 end
end
