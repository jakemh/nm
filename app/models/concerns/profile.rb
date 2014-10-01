module Profile
  extend ActiveSupport::Concern
    included do
     # field: profile_photo_id, type: Integer
     # before_create: :notify_on_create
     # scope: my_scope, ->(var) { where(slug: var) }
    has_many :photos, :as => :imageable, :dependent => :destroy

   end

   def profile_photo
     if self.profile_photo_id
       self.photos.find(self.profile_photo_id)
     end
   end

   def thumb
     if profile_photo
       profile_photo.image.url(:square)
     end
   end
  # def self.included(base)
  #   base.field :profile_photo_id, :type => Integer                     
  # end

end
