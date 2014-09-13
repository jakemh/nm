class TemporaryController < ApplicationController
  def index
    @email = Email.new
  end

  def new
  end

  def create
  end
end
