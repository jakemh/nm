class TemporaryController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate
  skip_before_action :authenticate_user!

  def index
    @email = Email.new
    if current_user
      if Rails.env.production?
        redirect_to me_feed_index_path
      end
    else 
      redirect_to new_user_registration_path
    end
  end

  def new
  end

  def create
  end
end
