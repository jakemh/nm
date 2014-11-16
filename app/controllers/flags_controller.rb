class FlagsController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
    entity.flags.create whitelist.marge({:user_id => whitelist[:issued_by_user]})
  end

  def edit

  end

  def update
  end

  private
  def whitelist
    params.require(:flag).permit(:category, :description, :issued_by_user)
  end
end
