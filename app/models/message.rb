class Message < Post
  belongs_to :user
  belongs_to :business
  # has_many :recipients
  has_many :responses, :class_name => "MessageResponse", :foreign_key => "parent_id"

end