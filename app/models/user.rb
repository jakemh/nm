class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :ownerships
  has_many :businesses, :through => :ownerships, :source => :connect_to
  has_many :connections
  has_many :friendships
  has_many :business_connections
  has_many :friends, :through => :friendships, :source => :connect_to
  # has_many :businesses, :through => :business_connections, :source => :connect_to
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :roles
  has_many :posts
  has_many :user_posts
  has_many :business_posts, :through => :businesses, :source => :posts

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # validates_uniqueness_of :email
  validates :is_veteran, :acceptance => {:accept => true}

  # validates :email, :presence => true
  validates :password, :presence => true
  validates :last_name, :presence => true
  validates :first_name, :presence => true
  validates :zip, :presence => true

  def is_veteran_accepted?
    self.errors[:is_veteran].length == 0
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def all_posts
    (self.posts + self.business_posts).sort_by{|p| p.created_at}.reverse
  end

  def pending_friends
    self.inverse_friends.where("connections.user_id not in (?)", self.friends.pluck(:id).join(''))
  end

end
