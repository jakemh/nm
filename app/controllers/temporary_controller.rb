class TemporaryController < ApplicationController
  skip_authorization_check
  def index
    @email = Email.new
    if current_user
      if Rails.env.production?
        redirect_to user_feed_index_path
      end
    end
  end

  def new
  end

  def create
  end
end
