class PhotosController < ApplicationController
  layout "signup_bar"

  
  def index
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
    @photo = entity.photos.build whitelist
    if @photo.save

      respond_to do |format|
        format.js 
      end
      # render :json => {:files =>{:photo => @photo.image.url(:medium)}}
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
  protected
  def default_entity
    entity || current_user
  end

  def entity
    nil
  end

  private
  def whitelist
    params.require(:photo).permit(:image)
  end


end
