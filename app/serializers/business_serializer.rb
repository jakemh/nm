class BusinessSerializer < EntitySerializer
  attributes :message_route

  def message_route
  	"businesses/#{object.id}/messages"  
  end
end
