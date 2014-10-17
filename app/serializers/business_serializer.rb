class BusinessSerializer < ActiveModel::Serializer
  include ProfileConcern
  attributes :id, :name, :website, :address, :thumb, :uri

  def thumb
    thumb_path(object)
  end

  def uri
    view_context.url_for(object)
  end
end
