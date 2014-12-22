class Review < ActiveRecord::Base
  belongs_to :reviewable, :polymorphic => true

  def reviewer
    User.find self.user_id || User.new
  end
end
