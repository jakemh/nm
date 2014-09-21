class Business < ActiveRecord::Base
  has_many :owernships
  has_many :users, :through => :ownerships
  has_many :tags, :as => :taggable
  has_many :posts, :source => :business_posts
  has_many :photos, :as => :imageable, :dependent => :destroy


  validates :zip, :presence => true
  # validates :website, :presence => true

  validates :name, :presence => true
  # validates :address, :presence => true
  # validates :city, :presence => true
  # validates :state, :presence => true
  # validates :industry, :presence => true


  accepts_nested_attributes_for :tags, :photos

  def self.industries
    ["Accounting", "Advertising & Marketing", "Arts", "Banking", "Biotech & Pharmaceuticals", "Business/Personal Coaching", "Economy", "Education", "Energy & Utilities", "Entrepreneur", "Fashion", "Finance", "Health Care", "Health & Wellness", "Hospitality & Tourism", "Human Resources", "International", "Law", "Manufacturing", "Management", "Marketing", "Media & Entertainment", "Nonprofits", "Politics", "Publishing", "Professional Services", "Real Estate", "Restaurants", "Retail & Apparel", "Small Business", "Social Media", "Sports & Fitness", "Startups", "Technology - All areas", "Telecommunications", "Transportation", "Wall Street"]
  end

  def self.types
    ["type1", "type2", "type3"]
  end
end
