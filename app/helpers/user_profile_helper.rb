
module UserProfileHelper
  def active_class(path)
    if path
      "active" if current_page? path
    end
  end

  def send_or_nil(path, *args)
    if path
      send(path, args)
    else nil
    end
  end

  def thumb(entity, opt={})
    content_tag :div, :class => opt[:class] do
      if entity.profile_photo
          image_tag entity.thumb
      else
          if entity.class.name == "Business"
            image_tag "default_business.png"
          else image_tag "default_user.png"
          end
      end
    end
  end
  
end
