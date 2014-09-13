class Me::UsersController < MeController
  layout "profile"
  
  def index
  end

  def show
    @user = current_user
  end
end
