class UsersController < ApplicationController
  layout 'profile'
  def index
    @users = User.where("users.id != ?", current_user.id)
  end

  def show
  end
end
