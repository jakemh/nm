class Admin::UsersController < Admin::AdminController

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
      :is_admin?,
      :sign_in_count, 
      :current_sign_in_at, 
      :last_sign_in_at, 
      :current_sign_in_ip, 
      :last_sign_in_ip, 
      :created_at, 
      :updated_at
    ] 
    
  end

  def update

  end

  protected

    def model_type
      User
    end

    def whitelist

    end

end
