module SqlConcern
  extend ActiveSupport::Concern

  included do
   
  end


  def entity_condition(business_ids = nil, user_id = nil)
    ["business_id IN (?) OR user_id IN (?)", business_ids || current_user.businesses.pluck(:id), user_id || current_user.first.id]
  end
  
end