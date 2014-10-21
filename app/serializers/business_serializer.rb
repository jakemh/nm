class BusinessSerializer < ActiveModel::Serializer
  include ProfileConcern
  attributes :id, :name, :website, :address, :thumb, :uri, :latitude, :longitude

  def thumb
    thumb_path(object)
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
