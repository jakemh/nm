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
    @entity = set_entity
    # ratio = 1680.0 / 704.0
    ratio = 1
    photo = @entity.photos.find params[:id]
    if params[:crop_x] && params[:crop_y] && params[:crop_h] && params[:crop_w] 
      coords = { "crop_x" => params[:crop_x] * ratio, "crop_y" => params[:crop_y] * ratio, "crop_h" => params[:crop_h] * ratio, "crop_w" => params[:crop_w] * ratio}
      coords.each{|k,v| photo.instance_variable_set("@#{k}",v)};
      photo.crop_image
    end
    render json: photo
  end

  def destroy
  end

  protected

  def build_photo(entity)
    return entity.photos.build(image: whitelist[:file], type: whitelist[:type])
  end
  
  def whitelist
    return params.require(:photo).permit(:file, :type, :crop_x, :crop_y, :crop_w, :crop_h) if params[:photo]
    return params.permit(:file, :type) if params[:file]

  end


end
