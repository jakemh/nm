class BusinessSerializer < EntitySerializer
  attributes :message_route, :email, :phone, :owner_id, :cover_photo

  def owner_id
    if object.ownerships.first
      object.ownerships.first.user_id
    end
  end

  def message_route
  	"businesses/#{object.id}/messages"  
  end
end
