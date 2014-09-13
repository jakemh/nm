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


  protected
    def whitelist
      params.require(:email).permit(:email)
    end
end
