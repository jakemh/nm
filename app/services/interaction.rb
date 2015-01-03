class Interaction
  include SqlConcern
  attr_accessor :entity

  def initialize(entity)
    @entity = entity
  end

  def total_messages_from(entity)
    
  end

  def total_points_from(entity)

  end

  def total_responses_from(entity)

  end

  def total_reviews_from(entity) 

  end

  def total_connections_from(entity)

  end

  def total_requests_from(entity)

  end
  
end
