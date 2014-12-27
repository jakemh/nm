class Admin::Alerts::Points::UsersController < Admin::AlertsController  
  
  def index
    super
    @users = @users.reject{|p| false}
    

  end

  protected
    def model_type
      User
    end
end
