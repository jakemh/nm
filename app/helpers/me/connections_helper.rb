module Me::ConnectionsHelper
  def follower_count(connection_entity)
    pluralize(connection_entity.followers.count, "follower")
  end

  def follower_type(is_inverse)
    is_inverse ? "Follower" : "Following"
  end

  def aud_member_class_type(index)
    (index.even? ? "aud__member--left" : "aud__member--right")
  end

  def connection_link(connection)
    # connection.kind_of?(Business) ? business_path(connection) : user_prof_path(connection)
  end
end
