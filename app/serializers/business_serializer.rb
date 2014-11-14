class BusinessSerializer < EntitySerializer
  attributes :message_route, :email, :phone, :owner_id

  def owner_id
    object.ownerships.first.user_id
  end

  def message_route
  	"businesses/#{object.id}/messages"  
  end
end
