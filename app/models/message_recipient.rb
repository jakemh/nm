class MessageRecipient < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
  belongs_to :message
end
