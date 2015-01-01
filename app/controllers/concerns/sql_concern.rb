module SqlConcern
  extend ActiveSupport::Concern

  included do
   
  end


  def entity_condition
    ["business_id IN (?) OR user_id IN (?)", User.first.businesses.pluck(:id), User.first.id]
  end
  
end