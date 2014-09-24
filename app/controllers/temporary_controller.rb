class TemporaryController < ApplicationController
  skip_authorization_check
  def index
    @email = Email.new
  end

  def new
  end

  def create
  end
end
