class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  def thumb
    entity.thumb if entity
  end

  def entity
    self.business || self.user
  end

  def entity_type
    if ["BusinessConnection", "Ownership"].include? self.type
      Business
    else 
      User
    end
  end

  def pending?
    !has_corresponding_inverse
  end

  def self.connection_type(entity)
    if entity.class.name == "Business"
      "BusinessConnection"
    elsif entity.class.name == "User"
      "Friendship"
    end
  end

  def has_corresponding_inverse
    Connection.where(:user_id => self.connect_to_id, :connect_to_id => self.user_id, :type => self.type).length > 0
  end
end
