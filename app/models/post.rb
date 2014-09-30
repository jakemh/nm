class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  def entity
    self.user || self.business
  end

  def thumb
    if entity
      entity.thumb
    end
  end
end
