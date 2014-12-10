class FollowingController < ApplicationController
   def index
     @following = entity.following
     render json: @following, each_serializer: FollowerSerializer
   end

  def show
    @following = parse_show_array(Connection)
    render json: @following, each_serializer: FollowerSerializer
  end

  def create
  end

  def destroy
  end
end
