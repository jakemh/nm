class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  INTRA_CONNECTION = "Friendship"
  INTER_CONNECTION = "BusinessConnection"


  include Profile

  include Messaging

  include Interaction 
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
  has_many :posts, dependent: :destroy
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

  def is_veteran_accepted?
    self.errors[:is_veteran].length == 0
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def contact
    self.email
  end
# 
  # def inverse_connections
  #   (self.inverse_friendships + self.inverse_business_connections).each{|c| c.is_inverse = true}.sort_by{|e| e.created_at}
  # end

  # def followers
  #   self.inverse_connections
  # end

  # def following
  #   self.connections.where.not(type: 'Ownership')
  # end

  # def follow(entity)
  #   if entity.class.name == "Business"
  #     self.connections.create(:connect_to_id => entity.id, :type => "BusinessConnection")
  #   elsif entity.class.name == "User"
  #     self.connections.create(:connect_to_id => entity.id, :type => "Friendship")

  #   end
  # end

  # def interacted_with
  #   (followers + following).sort_by{|e| e.created_at}
  # end

  # def has_connection?(entity)
  #   if entity == self
  #     "true"
  #   else
  #     if entity.class.name == "Business"
  #       self.connections.where(:type => ["BusinessConnection", "Ownership"], :connect_to_id => entity.id).length > 0
  #     elsif entity.class.name == "User"
  #       self.connections.where(:type => ["Friendship", "Ownership"], :connect_to_id => entity.id).length > 0

  #     end
  #   end
  # end

  # def connection_with(entity)
  #   if entity != self
  #     if entity.class.name != self.class.name
  #       self.connections.where(:type => [self.class::INTER_CONNECTION, "Ownership"], :connect_to_id => entity.id)
  #     else
  #       self.connections.where(:type => [self.class::INT_CONNECTION, "Ownership"], :connect_to_id => entity.id)
  #     end
  #   end
  # end
  def connection_with(entity)
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
