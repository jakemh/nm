class Me::BusinessesController < MeController

  layout 'layouts/profile'


  def index
    @owned_businesses = current_user.owned_businesses
  end

  def show
  end

  def new
    @business = Business.new
    @business.tags << Tag.new
  end

  def create
    tags = whitelist.delete(:tags_attributes)
    business = Business.new(whitelist)
    current_user.owned_businesses << business
    tags["0"]["name"].split(",").each do |tag|
      business.tags << Tag.new(:name => tag)
    end 
  end

  def destroy
  end


  protected
    def whitelist
      params.require(:business).permit(
        :name, 
        :address, 
        :website, 
        :city, 
        :state, 
        :address, 
        :zip,
        :description,
        tags_attributes: [:name]
      )
    end

end
