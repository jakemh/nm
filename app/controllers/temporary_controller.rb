class TemporaryController < ApplicationController
  skip_authorization_check
  def index
    @email = Email.new
    if current_user
      redirect_to user_feed_index_path
    end
  end

  def new
  end

  def create
  end
end
