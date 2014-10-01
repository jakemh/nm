class BusinessConnection < Connection
  belongs_to :connect_to, :class_name => "Business"
  validates :connect_to_id, :uniqueness => {:scope => [:user_id]}

end
