
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
      path = nil
      if entity.profile_photo
          path = entity.thumb
      else
          if entity.class.name == "Business"
            path = "default_business.png"
          else 
            path = "default_person.png"
          end
      end
      yield path if block_given?
    end
  end
  
end
