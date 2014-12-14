class ReceivedMessageSerializer < MessageSerializer
  attributes :unread, :to_entity_id, :to_entity_type, :type

  def unread
    object.unread?(scope.current_user)
    # object.to_entity.message_recipients.where(message_id: object.id).first.unread?(scope.current_user)
  end

  def type
    "ReceivedMessage"
  end

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
