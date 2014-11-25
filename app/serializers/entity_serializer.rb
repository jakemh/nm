class EntitySerializer < ActiveModel::Serializer
  include ProfileConcern
  attributes :id, :created_at, :name, :website
  attributes :address, :city
  attributes :thumb, :uri, :type
  attributes :latitude, :longitude, :distance
  attributes :follow_uri, :follower_uri_type, :follower_count

  has_many :followers, embed: :ids
  has_many :following, embed: :ids
  has_many :sent_messages, embed: :ids
  has_many :received_messages, embed: :ids

  # def followers
  #   object.
  # end
  def follower_count
    object.followers.count
  end

  def follow_uri
    # object.follow_uri
  end

  def follower_uri_type

    other = 
      if scope.params[:current_type] && scope.params[:current_id]
        scope.params[:current_type].constantize.find(scope.params[:current_id])
      else scope.current_user
      end

    return scope.follow_link(other, object)

  end

  # def inverse_follower_uri_type
  #   if scope.params[:current_type] && scope.params[:current_id]
  #     other = scope.params[:current_type].constantize.find(scope.params[:current_id])
  #     scope.follow_link(object, other)
  #   else nil
  #   end
  # end
  
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