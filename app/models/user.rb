class User < ActiveRecord::Base
  geocoded_by :zip
  searchkick text_start: [:first_name, :last_name, :email, :zip], 
  word_start: [:first_name, :last_name]

  User.reindex
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  INTRA_CONNECTION = "Friendship"
  INTER_CONNECTION = "BusinessConnection"
  # searchkick
  # User.reindex
  acts_as_reader
  
  include Profile
  include Messaging
  include Interaction 
  include Search

  has_many :skills
  # has_many :received_messages, -> { where(:to_entity => "User") }, class_name: "Message", foreign_key: :to_id
  has_many :intra_connections, class_name: INTRA_CONNECTION 
  has_many :inter_connections, class_name: INTER_CONNECTION
  has_many :inverse_intra_connections, class_name: INTRA_CONNECTION, foreign_key: :connect_to_id
  has_many :inverse_inter_connections, class_name: INTER_CONNECTION, foreign_key: :connect_to_id
  # has_many :received_messages, -> { where(:to_entity => "User") }, class_name: "Message", foreign_key: :to_id
  # has_many :message_recipients
  # has_many :received_messages, class_name: "Message", foreign_key: 
  has_many :assignments
  has_many :roles, :through => :assignments
  has_many :ownerships, dependent: :destroy
  has_many :businesses, :through => :ownerships, :source => :connect_to
  has_many :friendships
  has_many :business_connections
  # scope :business_associations, -> { where(published: true) }
  has_many :friends, :through => :friendships, :source => :connect_to
  # has_many :businesses, :through => :business_connections, :source => :connect_to
  # has_many :inverse_connections, :class_name => "Connection", :foreign_key => "connect_to_id", conditions:
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "connect_to_id"
  has_many :inverse_business_connections, :class_name => "BusinessConnection", :foreign_key => "connect_to_id"

  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :posts,  dependent: :destroy
  has_many :user_posts, dependent: :destroy
  has_many :business_posts, :through => :businesses, :source => :posts

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # validates_uniqueness_of :email
  validates :is_veteran, :acceptance => {:accept => true}

  # validates :email, :presence => true
  validates :password, :presence => true, :on => :create
  validates :last_name, :presence => true, :on => :create
  validates :first_name, :presence => true, :on => :create
  validates :zip, :presence => true, :on => :create

  def business_associations
    self.connections.where(:type => ["BusinessConnection", "Ownership"])
  end

  def all_posts
    -> { where(:to_entity => "Business") }
  end

  def self.by_first_letter(letter)
    raise "Not a letter" unless letter.kind_of?(String) && letter.length == 1
    User.where("first_name like ? OR last_name like ?", "#{letter}%", "#{letter}%")
  end

  def is_veteran_accepted?
    self.errors[:is_veteran].length == 0
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def contact
    self.email
  end

  def connection_with(entity)
    if entity.class.name == "Business"
      self.connections.where(:type => ["BusinessConnection", "Ownership"], :connect_to_id => entity.id)
    elsif entity.class.name == "User"
      self.connections.where(:type => ["Friendship"], :connect_to_id => entity.id)
    end
  end

  def inverse_connection_with(entity)
    if entity.class.name == "Business"
      self.connections.where(:type => ["BusinessConnection", "Ownership"], :connect_to_id => entity.id)
    elsif entity.class.name == "User"
      self.connections.where(:type => ["Friendship"], :connect_to_id => entity.id)
    end

  end
  
  def all_posts
    (self.posts + self.business_posts).sort_by{|p| p.created_at}.reverse
  end

  def pending_friends
    self.inverse_friends.where("connections.user_id not in (?)", self.friends.pluck(:id).join(''))
  end

  def role
    role = self.roles.first
    self.roles.first.name if role
  end

  def role?(role)
    return self.roles.pluck(:name).include? role
  end

  def address
    self.zip
  end
end
