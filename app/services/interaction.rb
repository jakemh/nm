class Interaction
  include SqlConcern
  attr_accessor :current_entity

  def initialize(current_entity)
    @current_entity = current_entity
  end

  def total_messages_from(entity)
    entity.received_messages.where(@current_entity.entity_id)
  end

  def total_post_points_from(entity)
    PostPoint.scored_by(entity).joins(:post).where("posts.#{@current_entity.entity_id.keys.first} = ?", @current_entity.id)
  end

  def total_responses_from(entity)
    entity.responses.joins("INNER JOIN posts as parents on parents.id = posts.parent_id").where("parents.#{@current_entity.entity_id.keys.first} = ?", @current_entity.id)
  end

  def total_reviews_from(entity) 
    entity.reviews.where(:reviewable_type => "Business", :reviewable_id => @current_entity.id)

  end 

  def total_connections_from(entity)
    entity.connection_with(@current_entity)
  end

  def total_interaction_count(entity)
    total = 0
    methods = [
    :total_messages_from,
    :total_post_points_from,
    :total_responses_from,
    :total_reviews_from,
    :total_connections_from,
    ] 

    methods.inject(0){ |count, m| count += send(m, entity).count}
  end

  # def total_requests_from(entity)
  #   # nothing to put here yet
  # end
  
end
