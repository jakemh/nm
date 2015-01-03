module SqlConcern
  extend ActiveSupport::Concern

  included do
   
  end


  def entity_condition(user)
    ["business_id IN (?) OR user_id IN (?)", user.businesses.pluck(:id), user.id]
  end
  
end