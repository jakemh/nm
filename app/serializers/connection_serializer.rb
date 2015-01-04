class ConnectionSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :user_id, :business_id, :connect_to_id, :type, 
  :entity_type, :connected_to_entity_type, :follow_uri
  # , :connection_entity
  # , :connection_type
  attributes :interactions, :interactions_in
  has_one :user, embed: :id
  has_one :business, embed: :id
  
  attr_accessor :interactions_out
  attr_accessor :interactions_in
  def follow_uri
    # follow_link(object, 
  end

  def interactions
    iOut = Interaction.new(object.connection_entity)
    iIn = Interaction.new(object.entity)
    interactions_out = iOut.total_interaction_count(object.entity)
    interactions_in = iIn.total_interaction_count(object.connection_entity)
    @interactions_in = interactions_in
    @interactions_out = interactions_out
    total_interactions = interactions_out + interactions_in
  end

  def entity_type
    object.entity_type.to_s
  end

  def connected_to_entity_type
    object.connected_to_entity_type.to_s
  end

  def connection_entity
    object.connection_entity.id
  end

  # def connection_type
  #   Connection.connection_type(object)
  # end
end
