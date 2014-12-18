class Flag < ActiveRecord::Base
  belongs_to :flaggable, :polymorphic => true
  # has_one :business
  def flagger
    if self.user_id
      User.find self.user_id
    else User.new
    end
  end

  def entity
    self.flaggable
  end
end
