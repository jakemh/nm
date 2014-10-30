class MessageSerializer < PostSerializer
  attributes :from_id, :type
  has_many :message_recipients
  # attributes :id
  # has_one :user, embed: :id
  # has_one :business,  embed: :id

  def from_id
    
  end

  def type
  end

end

