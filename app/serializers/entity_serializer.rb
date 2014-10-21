class EntitySerializer < ActiveModel::Serializer
  include ProfileConcern
  attributes :id, :name, :address, :thumb, :uri, :type, :latitude, :longitude

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
end