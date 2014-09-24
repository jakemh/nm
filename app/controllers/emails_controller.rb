class EmailsController < ApplicationController
  def new
    
  end

  def create
    @email = Email.create(whitelist)

    if @email.save
        flash[:notice] = "Thanks! You'll receive updates shortly."
        redirect_to root_path # This redirects to the show action, where the flash will be displayed
      else
        flash[:error] = "Something went wrong. Please tell Justin!"
        render :action => :new # This displays the new form again
    end
  end

  def destroy
    @email = Email.find(params[:id])
    if @email.destroy
        flash[:notice] = "Email was deleted"
        redirect_to_back # This redirects to the show action, where the flash will be displayed
      else
        flash[:error] = "Something went wrong. Please tell Justin!"
        redirect_to_back
    end
  end

  private
    def whitelist
      params.require(:email).permit(:email)
    end
end
