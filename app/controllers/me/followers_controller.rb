class Me::FollowersController < ApplicationController
  def index
    @followers = current_user.inverse_connections
    # .map{|f| f.entity_type.find_by_id(f.user_id)}
    
    render json: @followers, each_serializer: FollowerSerializer
  end

  def show
  end
end
