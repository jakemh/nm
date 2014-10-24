class Me::BusinessPhotosController < Me::PhotosController
  
  private
  def entity
    current_user.businesses.find(params[:business_id])
  end

  def path
    [:me, entity]
  end
 
end
