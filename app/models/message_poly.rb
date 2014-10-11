class MessagePoly < ActiveRecord::Base
    belongs_to :messageable, polymorphic: true
    belongs_to :user
    belongs_to :business
end
