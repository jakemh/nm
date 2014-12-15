class BusinessSerializer < EntitySerializer
  attributes :message_route, :email, :phone, :owner_id, :cover_photo_url, :description

  # has_many :business_friendships, embed: :id
  # has_many :business_connections, embed: :id
  # has_many :business_friends, embed: :id
  # has_many :user_connections, embed: :id
  has_many :user_connections, embed: :ids
  has_many :business_connections, embed: :ids
  has_many :reviews, embed: :ids
  
  def business_connections
    object.business_friends
  end

  def user_connections
    object.user_friends
  end

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
