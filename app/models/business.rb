class Business < ActiveRecord::Base
  geocoded_by :zip
  searchkick text_start: [:name, :address, :website, :city, :state, :zip, :business_type, :industry, :description],
  word_start: [:name, :description]
  # searchkick text_start: [:zip]
  Business.reindex
  INTRA_CONNECTION = "BusinessFriendship"
  INTER_CONNECTION = "BusinessConnection"
  # acts_as_gmappable
  include Profile
  include Interaction
  include Messaging
  include Directory
  include Search

  # has_many :received_messages, -> { where(:to_entity => "Business") }, class_name: "Message", foreign_key: :to_id
  has_many :ownerships, foreign_key: :connect_to_id
  has_many :business_friendships
  has_many :business_connections
  has_many :users, :through => :ownerships
  has_many :tags, :as => :taggable
  has_many :intra_connections, class_name: INTRA_CONNECTION 
  has_many :inter_connections, class_name: INTER_CONNECTION
  has_many :inverse_intra_connections, class_name: INTRA_CONNECTION, foreign_key: :connect_to_id
  has_many :inverse_inter_connections, class_name: INTER_CONNECTION, foreign_key: :connect_to_id 
  
  # has_many :business_posts, dependent: :destroy
  # has_many :posts, :source => :business_posts
  has_many :posts, dependent: :destroy
  validates :zip, :presence => true
  # validates :website, :presence => true
  validates :name, :presence => true
  validates :name, :uniqueness => true

  # validates :address, :presence => true
  # validates :city, :presence => true
  # validates :state, :presence => true
  # validates :industry, :presence => trues

  accepts_nested_attributes_for :tags, :photos
  
  def connection_with(entity)
    if entity.class.name == "Business"
      self.connections.where(:type => [INTRA_CONNECTION])
    elsif entity.class.name == "User"
      self.connections.where(:type => [INTER_CONNECTION])
    end
  end

  def self.by_first_letter(letter)
    raise "Not a letter" unless letter.kind_of?(String) && letter.length == 1
    Business.where("name like ?", "#{letter}%")
  end

  def self.random(quant)
    Business.where.not(:id => [User.first.connections.where(:type => ["BusinessConnection", "Ownership"]).pluck(:id)]).order("RANDOM()").limit(quant)
  end

  def self.industries
    ["Accounting", "Advertising & Marketing", "Arts", "Banking", "Biotech & Pharmaceuticals", "Business/Personal Coaching", "Economy", "Education", "Energy & Utilities", "Entrepreneur", "Fashion", "Finance", "Health Care", "Health & Wellness", "Hospitality & Tourism", "Human Resources", "International", "Law", "Manufacturing", "Management", "Marketing", "Media & Entertainment", "Nonprofits", "Politics", "Publishing", "Professional Services", "Real Estate", "Restaurants", "Retail & Apparel", "Small Business", "Social Media", "Sports & Fitness", "Startups", "Technology - All areas", "Telecommunications", "Transportation", "Wall Street"]
  end

  def self.types
    ["type1", "type2", "type3"]
  end
  
  def contact
    self.website
  end
  
end
