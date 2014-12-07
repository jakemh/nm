class BusinessSerializer < EntitySerializer
  attributes :message_route, :email, :phone, :owner_id, :cover_photo_url, :description

  def cover_photo_url
    # if object.cover_photos.count > 0
    #   object.cover_photos.last.image.url(:medium)
    # else nil
    # end
    if object.cover_photo_id
      if object.cover_photo
        object.cover_photo.image.url :medium
      end
    end
  end

  def owner_id
    if object.ownerships.first
      object.ownerships.first.user_id
    end
  end


  def address
    object.address.capitalize if object.address
  end

  
  def message_route
  	"businesses/#{object.id}/messages"  
  end
end
