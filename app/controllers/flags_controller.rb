class FlagsController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
    flag = entity.flags.build whitelist.merge({:user_id => current_user.id})
    if flag.save
      render :json => {:status => true}
    else render :json => {:status => false}
    end
  end

  def edit

  end

  def update
  end

  private
  # def entity
  #   params[:type].constantize.find(params[:id])
  # end

  def whitelist
    params.require(:flag).permit(:category, :description)
  end
end
