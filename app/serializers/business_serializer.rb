class BusinessSerializer < EntitySerializer
  attributes :message_route, :email, :phone

  def message_route
  	"businesses/#{object.id}/messages"  
  end
end
