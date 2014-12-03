class PhotosController < ApplicationController
  # layout "signup_bar"
  skip_before_filter :verify_authenticity_token

  
  def index
    render :json => {:status => true}
  end

  def show
  end

  def new
    @entity = set_entity
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
    @photo = build_photo(@entity)

    
    if @photo.save
      # respond_to do |format|
      #   format.js 
      # end
      render :json => @photo
    else
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def build_photo(entity)
    return entity.photos.build(image: whitelist[:file], type: whitelist[:type])
  end
  
  def whitelist
    return params.require(:photo).permit(:file, :type) if params[:photo]
    return params.permit(:file, :type) if params[:file]

  end


end
