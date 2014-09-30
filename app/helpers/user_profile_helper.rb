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
end
