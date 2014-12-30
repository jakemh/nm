class CoverPhotoSerializer <  PhotoSerializer

  def url
    object.image.url
  end

end
