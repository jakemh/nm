class Ownership < Connection
  validates :connect_to_id, :uniqueness => {:scope => [:user_id]}

  # belongs_to :user
  # belongs_to :business

end
