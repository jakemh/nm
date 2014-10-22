class EntitySerializer < ActiveModel::Serializer
  include ProfileConcern
  attributes :id, :created_at, :name, :address, :thumb, :uri, :type, :latitude, :longitude, :distance

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