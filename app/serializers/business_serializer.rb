class BusinessSerializer < EntitySerializer
  attributes :website, :message_route

  def message_route
  	"businesses/#{object.id}/messages"  
  end
end
