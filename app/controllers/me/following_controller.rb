class Me::FollowingController < ApplicationController
  def index
    @following = current_user.following.map{|f| [f.entity_type.find_by_id(f.connect_to_id), f]}.compact
    render json: @following, each_serializer: FollowingSerializer
  end

  def show
  end
end
