class Me::UsersController < MeController
  layout "profile"
  
  def index
    redirect_to user_feed
  end

  def show
    @user = current_user
    redirect_to user_feed_index_path
  end

  def update
    @user = current_user

    if @user.update_attributes(whitelist)
      # redirect_to [:me, @business]
      flash[:notice] = "Your account has been successfully updated."
      redirect_to user_path
    else

      flash[:error] = "Error. Your account was not successfully updated. Alert Justin!"
      redirect_to user_path

      # render :action => 'new', :layout => 'signup_bar'
    end
  end

  protected
    def whitelist
      params.require(:user).permit(
        :profile_photo_id      
      )
    end
end
