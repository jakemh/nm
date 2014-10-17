module ProfileConcern
  extend ActiveSupport::Concern


  def thumb_path(entity)
    if entity.profile_photo
        path = entity.thumb
    else
        if entity.class.name == "Business"
          path = "default_business.png"
        else 
          path = "default_person.png"
        end
    end
    return view_context.image_path(path)
  end
end