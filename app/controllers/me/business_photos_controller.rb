class Me::BusinessPhotosController < Me::PhotosController
  
  protected
  def entity
    current_user.businesses.find(params[:business_id])
  end

  def path
    [:user, entity]
  end
 
end
