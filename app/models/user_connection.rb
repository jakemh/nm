class UserConnection < Connection
  
  belongs_to :connect_to, :class_name => "User"
  validates :connect_to_id, :uniqueness => {:scope => [:business_id]}

end
