class PhotosController < ApplicationController
  layout "signup_bar"
  skip_before_filter :verify_authenticity_token

  
  def index
    render :json => {:status => true}
  end

  def show
  end

  def new
    @entity = entity
    @photo = Photo.new
  end

  def create
    # if path
    #   @path = path
    # end
    # @user = current_user
    # @entity = entity

    # @photo = default_entity.photos.build whitelist
   
    @photo = entity.photos.build(image: whitelist[:file], type: whitelist[:type])
    if @photo.save

      # respond_to do |format|
      #   format.js 
      # end
      render :json => @photo.image.url(:medium)
    else
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  #override
  # protected
  # def default_entity
  #   entity || current_user
  # end

  # def entity
  #   nil
  # end

  private
  def whitelist
    return params.require(:photo).permit(:image, :type) if params[:photo]
    return params.permit(:file, :type) if params[:file]

  end


end