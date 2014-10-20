class UsersController < ApplicationController
  layout "external_profile_user"  
  include FeedConcern

  def index
    @users = User.where("users.id != ?", current_user.id)
    respond_to do |format|
      format.html
      format.json {render json: @users}
    end
  end

  def show
    @message = Message.new
    @post = Post.new
    #refactor this name
    @select = select_array
    user = User.find(params[:id])
    # @entity = user
    @default_entity = user
    @posts = build_sorted_posts(user.posts.where(type: [nil, ""]))

  end
end
