class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  def entity
    self.user || self.business
  end

  def entity_type
    if entity
      entity.class.name
    end
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
