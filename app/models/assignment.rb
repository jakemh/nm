class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  validates :role_id, presence: true, uniqueness: {scope: :user_id}

  def entity
     if self.user_id
       User.find user_id
     elsif self.business_id
       Business.find business_id
     else GenericEntity.new
     end
   end

  
end

