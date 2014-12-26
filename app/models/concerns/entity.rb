module Entity
  extend ActiveSupport::Concern

  included do
    has_many :flags, :as => :flaggable
    has_many :photos, :as => :imageable, :dependent => :destroy
    has_one :score, :as => :scoreable
    # has_many :votes, :through => :posts, :source => :points
    #  scope :votes, -> { Point.all.where(published: true) }
 
  end

  def entity_id
    if self.class.to_s == "Business"
      {:business_id => self.id}
    elsif self.class.to_s == "User"
      {:user_id => self.id}
    end
  end

  def votes
    Point.all.where(entity_id)
  end

  def profile_photo
    if self.profile_photo_id
      self.profile_photos.find self.profile_photo_id
    end
  end

  def last_vote_for(object)
    self.votes.where(:pointable_id => object.id, :pointable_type => object.class.name).last
    # self.points.where(:)
  end

end
