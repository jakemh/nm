class EntitySerializer < ActiveModel::Serializer
  include ProfileConcern
  attributes :id, :created_at, :name, :address, :thumb, :uri, :type, :latitude, :longitude, :distance, :follow_uri, :follower_uri_type

  has_many :followers, embed: :ids
  has_many :following, embed: :ids
  has_many :sent_messages, embed: :ids
  has_many :received_messages, embed: :ids

  # def followers
  #   object.
  # end

  def follow_uri
    # object.follow_uri

    
  end

  def follower_uri_type
    if scope.params[:current_type] && scope.params[:current_id]
      other = scope.params[:current_type].constantize.find(scope.params[:current_id])
      scope.follow_link(object, other)
    else nil
    end
  end
  
  def thumb
    thumb_path(object)
  end

  def type
    object.class.name
  end

  def uri
    view_context.url_for(object)
  end

  def latitude
    object.location.latitude
  end

  def longitude
    object.location.longitude
  end

  def distance
    if scope.params[:distance] == 'true'
      object.location.distance_from([scope.current_user.location.latitude, scope.current_user.location.longitude])
     end
  end
end