class Admin::BusinessesController < Admin::AdminController

  def show
    @business = Business.find params[:id]

    @attributes = [
      :id, 
      :name, 
      :website, 
      :address, 
      :city, 
      :state, 
      :business_type, 
      :industry, 
      :description, 
      :created_at, 
      :updated_at, 
      :zip, 
      :phone, 
      :email
    ]
  end

  protected
    def model_type
      Business
    end
end
