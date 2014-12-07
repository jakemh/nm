class Friendship < SameToSame
  # validates :connect_to_id, :uniqueness => {:scope => [:user_id, :type]}
  # validates :connect_to_id, :uniqueness => {:scope => [:user_id]}
  belongs_to :connect_to, :class_name => "User"


  # belongs_to :user
  # belongs_to :friend, :class_name => "User"
  # validates :friend_id, :uniqueness => {:scope => :user_id}

  # def pending?
  #   !has_corresponding_inverse
  # end

  # def has_corresponding_inverse
  #   Friendship.where(:user_id => self.friend_id, :friend_id => self.user_id).length > 0
  # end


end
