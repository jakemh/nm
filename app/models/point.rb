class Point < ActiveRecord::Base
  belongs_to :pointable, :polymorphic => true
  # belongs_to :post, ->(object) {where(pointable_type: "Post")}, foreign_key: 'pointable_id'
  has_one :self_ref, :class_name => self, :foreign_key => :id

  has_one :post, :through => :self_ref, :source => :pointable, :source_type => Post

  def scorer
    if self.user_id
      User.find user_id
    elsif self.business_id
      Business.find business_id
    else GenericEntity.new
    end
  end

  def self.scored_by(entity)
    Point.where(entity.entity_id)
  end

  def self.scoring_entity(entity)

  end


  def entity
    self.pointable
  end


end