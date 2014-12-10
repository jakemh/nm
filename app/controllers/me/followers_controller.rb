class Me::FollowersController < ApplicationController
  def index
    @followers = []
    if !params[:entity_id] || !params[:entity_type]
      @followers = current_user.inverse_connections
    else
      @followers = params[:entity_type].constantize.find(params[:entity_id]).inverse_connections
    end
    # .map{|f| f.entity_type.find_by_id(f.user_id)}
    
    render json: @followers, each_serializer: FollowerSerializer
  end

  def show
    byebug
  end
end
