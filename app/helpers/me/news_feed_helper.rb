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
end
