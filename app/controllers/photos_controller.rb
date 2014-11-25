class PhotosController < ApplicationController
  # layout "signup_bar"
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
    # entity = nil
    #  p "SET ENTITY2"
    # if params[:business_id]
    #    p params[:business_id]
    #   entity =  Business.find(params[:business_id])
    #   p "ENTITY B: ", @entity
    # elsif params[:user_id]
    #   entity =  User.find(params[:user_id]) 
    #   p "ENTITY U: ", @entity

    #  else raise "Applicable entity not found!"

    #  end
    @entity = set_entity
    @photo = @entity.photos.build(image: whitelist[:file], type: whitelist[:type])
    
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

  private
  def whitelist
    return params.require(:photo).permit(:image, :type) if params[:photo]
    return params.permit(:file, :type) if params[:file]

  end


end
