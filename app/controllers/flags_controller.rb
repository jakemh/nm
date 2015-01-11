class FlagsController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
    flag = entity.flags.build whitelist
    if flag.save
      render :json => flag
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
    params.require(:flag).permit(:flaggable_type, :flaggable_id, :category)
  end
end
