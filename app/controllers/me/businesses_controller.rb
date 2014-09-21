class Me::BusinessesController < MeController
  layout "profile", :except => [:new, :create]

  def index
    @businesses = current_user.businesses
  end

  def show
    @business = current_user.businesses.find(params[:id])
    @post = BusinessPost.new
    @posts = @business.posts
  end

  def new
    @business = Business.new
    @business.tags << Tag.new
    render :action => 'new', :layout => 'signup_bar'
  end

  def create
    w = whitelist
    tags = w.delete(:tags_attributes)
    @business = current_user.businesses.build w

      if @business.save

        tags["0"]["name"].split(",").each do |tag|
          @business.tags << Tag.new(:name => tag)
        end 
        flash[:notice] = "Business has been successfully saved."
        redirect_to [:me, :businesses]
      else

        flash[:error] = "Error. Business was not saved successfully."
        # format.html { redirect_to me_business_path(business) }
        render :action => 'new', :layout => 'signup_bar'

      end
    
  end

  def destroy
    business = current_users.business.find(params[:id])
    if business.destroy
      flash[:notice] = "Business has been successfully deleted"
    else
      flash[:error] = "Error. Business was not successfully deleted"
    end
    redirect_to :back
  end


  protected
    def whitelist
      params.require(:business).permit(
        :name, 
        :address, 
        :website, 
        :industry,
        :city, 
        :state, 
        :address, 
        :zip,
        :description,
        tags_attributes: [:name]
      )
    end

end
