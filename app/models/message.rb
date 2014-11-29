class Message < Post
  belongs_to :user
  belongs_to :business
  has_many :recipients
  scope :from_entity, -> (entity) { where(Post.id_sym(entity.class.name) => entity.id) }

  has_many :responses, :class_name => "MessageResponse", :foreign_key => "parent_id"
  include Messaging

  
end