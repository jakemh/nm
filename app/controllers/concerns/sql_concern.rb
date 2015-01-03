module SqlConcern
  extend ActiveSupport::Concern

  included do
   
  end


  def entity_condition(business_ids = nil, )
    ["business_id IN (?) OR user_id IN (?)", current_user.businesses.pluck(:id), current_user.first.id]
  end
  
end