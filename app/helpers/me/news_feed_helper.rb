module Me::NewsFeedHelper
  # DEFAULT_PHOTO = 
  def follow_link(user, entity)
    if entity != user
      if !user.has_connection?(entity)
        link_to "Follow", me_connections_path(:connect_to_id => entity, :type => Connection.connection_type(entity)), :method => :post 
      else
        "is following"
      end
    end
  end


  def image_helper(user)
    if user.thumb
      image_tag current_user.thumb
    else link_to "Add photo", new_user_photo_path
    end
  end
end
