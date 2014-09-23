class Me::BusinessPhotosController < ApplicationController
  layout "signup_bar"


  def index
  end

  def show
  end

  def new
    @business = Business.find params[:business_id]
    @photo = Photo.new
  end

  def create
    @business = current_user.businesses.find(params[:business_id])
    @photo = @business.photos.build whitelist
    if @photo.save
      Rails.logger.info "Year: #{Time.now.year}"

      respond_to do |format|
        format.js
      end
      # render :json => {:files =>{:photo => @photo.image.url(:medium)}}
    else
      Rails.logger.info "Error"
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
    params.require(:photo).permit(:image)
  end
end
