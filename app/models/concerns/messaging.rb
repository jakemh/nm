module Messaging
  extend ActiveSupport::Concern

  included do
    has_many :messages
    has_many :sent_messages, class_name: "Message"
    has_many :message_recipients, dependent: :destroy
    has_many :received_messages, through: :message_recipients, source: :message
  end

  def send_message_to(to_list = [], hash = {})
    m = self.sent_messages.build(hash)
    m.save
    to_list.each do |entity|
      r = entity.message_recipients.build({message_id: m.id})
      r.save
    end
    return m
  end
end
