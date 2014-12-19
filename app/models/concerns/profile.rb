module Profile
  extend ActiveSupport::Concern
  included do
    # field: profile_photo_id, type: Integer
    # before_create: :notify_on_create
    # scope: my_scope, ->(var) { where(slug: var) }
    has_many :photos, :as => :imageable, :dependent => :destroy
    has_many :profile_photos, :as => :imageable
    has_one :profile_photo, :as => :imageable


  end
  
  # def profile_photo
  #   if self.profile_photo_id
  #     self.photos.find_by_id(self.profile_photo_id)
  #   end
  # end

  def small_thumb
    if profile_photo
      profile_photo.image.url(:thumb)
    else
    end
  end

  def medium_photo
    if self.profile_photo && self.profile_photo.image
      self.profile_photo.image.url :medium
    end 
  end

  def profile_photo
    if self.profile_photo_id
      self.profile_photos.find self.profile_photo_id
    end
  end

  def medium_cover
    if self.cover_photo && self.cover_photo.image
      self.cover_photo.image.url :medium
    end
  end

  def thumb
    if profile_photo
      profile_photo.image.url(:square)
    end
  end

  # def thumb_path(entity)
  #   if entity.profile_photo
  #       path = entity.thumb
  #   else
  #       if entity.class.name == "Business"
  #         path = "default_business.png"
  #       else 
  #         path = "default_person.png"
  #       end
  #   end
  #   return view_context.image_path(path)
  # end
  # def self.included(base)
  #   base.field :profile_photo_id, :type => Integer
  # end

end
