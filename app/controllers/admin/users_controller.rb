class Admin::UsersController < Admin::AdminController
  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]

    @attributes = [
      :id, 
      :email, 
      :first_name, 
      :last_name, 
      :zip, 
      :is_veteran, 
      :city, 
      :work, 
      :website, 
      :about,
      :sign_in_count, 
      :current_sign_in_at, 
      :last_sign_in_at, 
      :current_sign_in_ip, 
      :last_sign_in_ip, 
      :created_at, 
      :updated_at
    ] 
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
