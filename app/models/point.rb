class Point < ActiveRecord::Base
  belongs_to :pointable, :polymorphic => true

  def scorer
    if self.user_id
      User.find user_id
    elsif self.business_id
      Business.find business_id
    else User.new
    end
  end

  def entity
    self.pointable
  end

end
