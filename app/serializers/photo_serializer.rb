class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :url

  def url
    object.image.url(:medium)
  end

end
