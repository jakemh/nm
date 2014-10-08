class Admin::BusinessesController < Admin::AdminController
  def index
    @businesses = Business.all
  end

  def show
  end

  def destroy
    @business = Business.find(params[:id])
    if @business.destroy
        flash[:notice] = "Business was deleted"
        redirect_to_back # This redirects to the show action, where the flash will be displayed
      else
        flash[:error] = "Something went wrong. Please tell Justin!"
        redirect_to_back
    end
  end
end