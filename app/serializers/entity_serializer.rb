class EntitySerializer < ActiveModel::Serializer
  include ProfileConcern
  attributes :id, :name, :address, :thumb, :uri, :type

  def thumb
    thumb_path(object)
  end

  def type
    object.class.name
  end

  def uri
    view_context.url_for(object)
  end
end