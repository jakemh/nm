class Me::BusinessPhotosController < Me::PhotosController
  
  protected
  def entity
    current_user.businesses.find(params[:business_id])
  end
  

  # def index
  # end

  # def show
  # end

  # # def new
  # #   @business = entity
  # #   @photo = Photo.new
  # # end

  # # def create
  # #   @business = entity
  # #   @photo = @business.photos.build whitelist
  # #   if @photo.save

  # #     respond_to do |format|
  # #       format.js
  # #     end
  # #     # render :json => {:files =>{:photo => @photo.image.url(:medium)}}
  # #   else
  # #   end
  # # end

  # def edit
  # end

  # def update
  # end

  # def destroy
  # end

 
end
