class Message < Post
  belongs_to :user
  belongs_to :business
  has_many :recipients
  scope :from_entity, -> (entity) { where(Post.id_sym(entity.class.name) => entity.id) }
  acts_as_readable :on => :created_at

  attr_accessor :to_entity
  # has_many :responses, :class_name => "MessageResponse", :foreign_key => "parent_id"
  include Messaging

  def read?(entity)
    self.received_messages.where(message_id: self.id).first.unread?(entity)
  end



end 