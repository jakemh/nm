class Message < Post
  belongs_to :user
  belongs_to :business
  has_many :recipients

end