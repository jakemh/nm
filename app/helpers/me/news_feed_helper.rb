module Me::NewsFeedHelper
  # DEFAULT_PHOTO = 
  def follow_link(user, entity)
    if entity != user && entity

      connection = user.connection_with(entity)
      p "CONNECTION: ", connection.inspect

      if !connection || connection.length == 0
        link_to "Follow", me_connections_path(:connect_to_id => entity, :type => Connection.connection_type(entity)), :method => :post 
      elsif connection.first.type == "Ownership"
        "My Business"
      else
        link_to "Remove", [:user, connection.first], method: :delete
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
