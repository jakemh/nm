class FollowerSerializer < ConnectionSerializer
  attributes :interactions

  def interactions
    i = Interaction.new(object.entity)
    i.total_interaction_count(object.connection_entity)
  end

end
