class ProfilePhotoSerializer < PhotoSerializer
  attributes :id
  def url
    object.image.url
  end

  
end
