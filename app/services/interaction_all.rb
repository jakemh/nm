class InteractionAll < Interaction

  def total_messages_to
    @current_entity.received_messages
  end

  def total_post_points_to
    @current_entity.posts
    .joins(:points)
    .where.not("points.#{@id_string} = ? AND points.#{@id_string} IS NOT NULL", @current_entity.id)
  end

  def total_responses_to
    Response.all.joins("INNER JOIN posts as parents on parents.id = posts.parent_id").where("parents.#{@id_string} = ?", @current_entity.id)
  end

  def total_reviews_to
    Review.sent_to(@current_entity)
  end 

  def total_inverse_intra_connections_to
    @current_entity.inverse_intra_connections
  end

  def total_inverse_inter_connections_to
    @current_entity.inverse_inter_connections
  end

  def total_connections_to
    @current_entity.inverse_connections
  end

  def total_count(range = [])
    total = 0
    methods = [
      :total_messages_to,
      :total_post_points_to,
      :total_responses_to,
      :total_reviews_to,
      :total_inverse_intra_connections_to,
      :total_inverse_inter_connections_to
    ] 

    methods.inject(0){ |count, m| count += send(m).where(:created_at => range[0]..range[1]).count }

  end

end
