class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
  attr_accessor :is_inverse

  def thumb
    entity.thumb if entity
  end

  def entity
    self.business || self.user
  end

  def entity_type
    if ["BusinessConnection", "Ownership", "BusinessFriendship"].include? self.type
      Business
    else 
      User
    end
  end

  def connected_to_entity_type
    if ["BusinessConnection", "Ownership", "BusinessFriendship"].include? self.type
      Business
    else 
      User
    end
  end

  # def connection_entity_inverse
  #   entity_type.find(self.user_id)
  # end

  def connection_entity
    if self.is_inverse
      entity_type.find(self.user_id)
    else
      entity_type.find(self.connect_to_id)
    end
  end 

  def pending?
    !has_corresponding_inverse
  end

  def self.connection_type(current_type, entity_type)
    if current_type == "User"
      return "BusinessConnection" if entity_type == "Business"
      return "Friendship" if entity_type == "User"
    elsif current_type == "Business"
      return "BusinessConnection" if entity_type == "User"
      return "BusinessFriendship" if entity_type == "Business"
    end 
  end

  def has_corresponding_inverse
    Connection.where(:user_id => self.connect_to_id, :connect_to_id => self.user_id, :type => self.type).length > 0
  end
end
