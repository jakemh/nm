class Post < ActiveRecord::Base
  attr_accessor :top_voter_hash

  belongs_to :user
  belongs_to :business
  validates :content, presence: true, allow_blank: false
  has_many :points, :as => :pointable
  has_one :score, :as => :scoreable
  # has_many :message_recipients
  has_many :responses, :class_name => "Response", :foreign_key => "parent_id", dependent: :destroy
  
  def self.id_sym(type)
    h = {
      "Business" => "business_id",
      "User" => "user_id"
    }
    h[type]
  end
  
  def entity
    self.user || self.business || User.new
  end

  def total_points
    self.points.sum(:score)
  end

  def last_vote_from_user
    self.points.sum(:score)
  end

  def add_response(opt)
    Response.create(opt.merge({:parent_id => self.id}))
  end

  def entity_type
    if entity
      entity.class.name
    end
  end

  def entity_name
    entity.name if entity
  end

  def top_voter
    if !self.top_voter_hash.empty?
      h = self.top_voter_hash.last
      if h[0][0]
        return User.find h[0][0]
      elsif h[0][1]
        return Business.find h[0][1]
      end
    else User.new
    end
  end

  def top_voter_points
    if !self.top_voter_hash.empty?
      h = self.top_voter_hash.last
      return h[1]
    else 0
    end
  end


  def top_voter_hash
    @top_voter_hash ||= build_top_voter
  end

  def build_top_voter
    hash = Point.where(:pointable_type => "Post", :pointable_id => self.id).group(:user_id, :business_id).sum(:score).sort_by{|k,v| v }
    return hash
  end

  def entity_id
    if entity
      entity.id
    end
  end

  def connection_from_entity
    if entity
      if entity.class.name == "Business"
        "BusinessConnection"
      elsif entity.class.name == "User"
        "Friendship"
      end
    end
  end

  def thumb
    if entity
      entity.thumb
    end
  end

  def self.follow_from(user, post)
    if entity.class.name == "Business"
      self.connections.create(:connect_to_id => entity.id, :type => "BusinessConnection")
    elsif entity.class.name == "User"
      self.connections.create(:connect_to_id => entity.id, :type => "Friendship")

    end
  end
end
