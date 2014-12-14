class MessageSerializer < ResponseSerializer
  
  attributes :unread, :to_entity_id, :to_entity_type,


  def to_entity_id
    if object.to_entity
      object.to_entity.id
    end
  end

  def to_entity_type
    if object.to_entity
      object.to_entity.class.name
    end
  end

end

