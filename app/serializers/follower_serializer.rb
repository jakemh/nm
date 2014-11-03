class FollowerSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :user_id, :business_id, :connect_to_id, :type, 
  :entity_type, :connected_to_entity_type, :follow_uri
  # , :connection_entity
  # , :connection_type
  has_one :user, embed: :id
  has_one :business, embed: :id
  def follow_uri
    # follow_link(object, 
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
