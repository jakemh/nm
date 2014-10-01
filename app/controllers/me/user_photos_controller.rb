class Me::UserPhotosController < Me::PhotosController
  protected
  def path
    [current_user]
  end
end
