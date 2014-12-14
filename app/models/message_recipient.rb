class MessageRecipient < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
  belongs_to :message
  acts_as_readable :on => :created_at


  def entity
    self.business || self.user
  end

end
