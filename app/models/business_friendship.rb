class BusinessFriendship < SameToSame
  belongs_to :connect_to, :class_name => "Business"
  validates :connect_to_id, :uniqueness => {:scope => [:business_id]}
  
 
 
  
end
