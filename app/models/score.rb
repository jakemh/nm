class Score < ActiveRecord::Base
  belongs_to :scoreable, :polymorphic => true

  def entity
    self.scoreable
  end
end
