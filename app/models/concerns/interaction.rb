require 'active_support/concern'


module Interaction
  extend ActiveSupport::Concern


  included do
    has_many :connections, dependent: :destroy

    # has_many :intra_connections, class_name: :intra_connection
    # has_many :inter_connections, class_name: :inter_connection
    # has_many :inverse_intra_connections, class_name: :intra_connection, foreign_key: :connect_to_id
    # has_many :inverse_inter_connections, class_name: :inter_connection, foreign_key: :connect_to_id
  end

  # def intra_connection
  #   raise 'must override'
  # end

  # def inter_connection
  #   raise 'must override'
  # end
  def entity
    {entity_id: self.id, entity_type: self.class.name}
  end

  def inverse_connections
    (self.inverse_intra_connections + self.inverse_inter_connections).each{|c| c.is_inverse = true}.sort_by{|e| e.created_at}
  end

  def followers
    self.inverse_connections
  end

  def following
    self.connections.where.not(type: 'Ownership')
  end

  def follow(entity)
    if entity.class.name == "Business"
      self.connections.create(:connect_to_id => entity.id, :type => self.class::INTER_CONNECTION)
    elsif entity.class.name == "User"
      self.connections.create(:connect_to_id => entity.id, :type => self.class::INTRA_CONNECTION)
    end
  end

  def interacted_with
    (followers + following).sort_by{|e| e.created_at}
  end

  def has_connection?(with_entity)
    if with_entity == self
      "true"
    else
      if with_entity.class.name == "Business"
        self.connections.where(:type => [self.class::INTER_CONNECTION, "Ownership"], :connect_to_id => with_entity.id).length > 0
      elsif with_entity.class.name == "User"
        self.connections.where(:type => [self.class::INTRA_CONNECTION, "Ownership"], :connect_to_id => with_entity.id).length > 0
      end
    end
  end

  def connection_with(entity)
    raise 'override this'
    # # if entity != self
    # #   self.connections.where(:connect_to_id => entity.id)
    # # end
    # if entity != self
    #   if entity.class.name != self.class.name
    #     self.connections.where(:type => self.class::INTER_CONNECTION, :connect_to_id => entity.id)
    #   else
    #     self.connections.where(:type => self.class::INTRA_CONNECTION, :connect_to_id => entity.id)
    #   end
    # end
  end
end
