class Admin::UsersController < Admin::AdminController
  def index
    @users = User.all
  end

  def show
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
        flash[:notice] = "User was deleted"
        redirect_to_back # This redirects to the show action, where the flash will be displayed
      else
        flash[:error] = "Something went wrong. Please tell Justin!"
        redirect_to_back
    end
  end
end
