class Review < ActiveRecord::Base
  belongs_to :reviewable, :polymorphic => true

  def reviewer
    User.find self.user_id || User.new
  end

  def self.sent_to(entity)
    Review.where(:reviewable_type => entity.class.to_s, :reviewable_id => entity.id)
  end

end
