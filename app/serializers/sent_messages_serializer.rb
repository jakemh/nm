class SentMessagesSerializer < MessageSerializer
  attributes :to_entity_id, :to_entity_type, :type
  attr_accessor :recipient
  def unread
    object.unread?(scope.current_user)
    # object.to_entity.message_recipients.where(message_id: object.id).first.unread?(scope.current_user)
  end

  def type
    "SentMessage"
  end

  def recipient
    @recipient ||= object.message_recipients.first
  end

  def to_entity_id
    if recipient
      recipient.business_id || recipient.user_id
    end
  end

  def to_entity_type
    if recipient
      if recipient.business_id
        "Business"
      elsif recipient.user_id
        "User"
      end
    end
  end

end
